//
//  FavoritesView.swift
//  FavoritiesPlannen
//
//  Created by Daniel Bartlsberger on 04.03.26.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    // Holt alle Zitate aus der Datenbank
    @Query(
        filter: #Predicate<Quote> { quote in
            quote.isFavorite == true
        }
    )
    private var favoriteQuotes: [Quote]
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    if favoriteQuotes.isEmpty == true {
                        ContentUnavailableView("Keine Favoriten", systemImage: "heart")
                    } else {
                        ForEach(favoriteQuotes) { quote in
                            QuoteRowView(quote: quote)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .listStyle(.plain)
            }
            .navigationTitle("Favoriten")
        }
    }
}

#Preview {
    FavoritesView()
}
