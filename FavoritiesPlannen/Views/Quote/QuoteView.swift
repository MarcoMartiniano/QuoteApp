//
//  FavoriteView.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var quotes: [Quote]
    
    @State private var filter: FilterType = .all
    
    enum FilterType: String, CaseIterable, Identifiable {
        case all = "Alle"
        case favorites = "Favoriten"
        case notFavorites = "Nicht Favoriten"
        
        var id: String { self.rawValue }
    }
    
    // MARK: - Filtered Quotes
    var filteredQuotes: [Quote] {
        switch filter {
        case .all:
            return quotes
        case .favorites:
            return quotes.filter { $0.isFavorite }
        case .notFavorites:
            return quotes.filter { !$0.isFavorite }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: - Picker
                Picker("Filter", selection: $filter) {
                    ForEach(FilterType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                // MARK: - List
                if filteredQuotes.isEmpty {
                    Spacer()
                    ContentUnavailableView(
                        "Keine Zitate vorhanden",
                        systemImage: "quote.bubble",
                        description: Text("Für den ausgewählten Filter gibt es momentan keine Zitate.")
                    )
                    Spacer()
                } else {
                    List {
                        ForEach(filteredQuotes) { quote in
                            QuoteRowView(quote: quote)
                        }
                        .onDelete(perform: deleteQuote)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Zitate")
        }
    }
    
    // MARK: - Delete
    private func deleteQuote(at offsets: IndexSet) {
        for index in offsets {
            let quoteToDelete = filteredQuotes[index]
            context.delete(quoteToDelete)
        }
        
        try? context.save()
    }
}

struct QuoteRowView: View {
    var quote: Quote
    @State private var bounce = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            
            Image(systemName: quote.category.sfSymbol)
                .font(.system(size: 40))
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(quote.author?.name ?? "Unbekannt")
                    .font(.headline)
                
                Text(quote.text)
                    .font(.callout)
                    .italic()
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                quote.isFavorite.toggle()
                
                withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                    bounce = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    bounce = false
                }
                
            } label: {
                Image(systemName: quote.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(.red)
                    .font(.system(size: 24))
                    .scaleEffect(bounce ? 1.2 : 1.0)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    QuoteView()
}
