//
//  FavoriteView.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import SwiftUI

// MARK: - FavoriteRowView
struct QuoteRowView: View {
    @State private var bounce = false
    @Binding var quote: Quote
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "globe")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(quote.author?.name ?? "")
                    .font(.headline)
                Text(quote.text)
                    .font(.callout)
                    .italic()
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                quote.isFavorite.toggle()
                
                withAnimation(.spring(response: 0.15, dampingFraction: 0.5)) {
                    bounce = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.spring(response: 0.15, dampingFraction: 0.5)) {
                        bounce = false
                    }
                }
                
            }) {
                Image(systemName: quote.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(.red)
                    .font(.system(size: 24))
                    .scaleEffect(bounce ? 1.2 : 1.0)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 8)
        .onAppear{
            
        }
    }
}

import SwiftUI

struct QuoteView: View {    
    @State private var quotes: [Quote] = InitiaEntryData.quotes
    @State private var filter: FilterType = .all
    
    enum FilterType: String, CaseIterable, Identifiable {
        case all = "Alle"
        case favorites = "Favoriten"
        case notFavorites = "Nicht Favoriten"
        
        var id: String { self.rawValue }
    }
    
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
                Picker("Filter", selection: $filter) {
                    ForEach(FilterType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                List {
                    ForEach($quotes) { $quote in
                        if filteredQuotes.contains(where: { $0.id == quote.id }) {
                            QuoteRowView(quote: $quote)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Zitate")
        }
    }
}

#Preview {
    QuoteView()
}
