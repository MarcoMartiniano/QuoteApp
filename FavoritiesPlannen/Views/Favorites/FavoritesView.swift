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
            List {
                
                if favoriteQuotes.isEmpty {
                    ContentUnavailableView("Keine Favoriten", systemImage: "heart")
                } else {
                    ForEach(favoriteQuotes) { quote in
                        
                        QuoteRowView(quote: quote)
                        
                            .swipeActions {
                                Button("Unfavorite") {
                                    quote.isFavorite = false
                                }
                                .tint(.pink)
                            }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Favoriten")
        }
    }
}

#Preview {
    FavoritesView()
}
