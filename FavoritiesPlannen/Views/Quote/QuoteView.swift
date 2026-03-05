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
                
                QuoteFilterPickerView(filter: $filter)
                
                if filteredQuotes.isEmpty {
                    Spacer()
                    QuoteEmptyStateView()
                    Spacer()
                } else {
                    QuoteListView(
                        quotes: filteredQuotes,
                        onDelete: deleteQuote
                    )
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

struct QuoteFilterPickerView: View {
    @Binding var filter: QuoteView.FilterType
    
    var body: some View {
        Picker("Filter", selection: $filter) {
            ForEach(QuoteView.FilterType.allCases) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

struct QuoteListView: View {
    let quotes: [Quote]
    let onDelete: (IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(quotes) { quote in
                QuoteRowView(quote: quote)
            }
            .onDelete(perform: onDelete)
        }
        .listStyle(.plain)
    }
}

struct QuoteEmptyStateView: View {
    var body: some View {
        ContentUnavailableView(
            "Keine Zitate vorhanden",
            systemImage: "quote.bubble",
            description: Text("Für den ausgewählten Filter gibt es momentan keine Zitate.")
        )
    }
}

#Preview {
    QuoteView()
}
