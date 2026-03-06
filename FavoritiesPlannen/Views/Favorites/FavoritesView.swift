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
            ZStack{
                Color(.colorBlue)
                    .ignoresSafeArea(.all)
                Group {
                    if favoriteQuotes.isEmpty {
                        Spacer()
                        FavoritesEmptyStateView()
                        Spacer()
                    } else {
                        FavoritesListView(quotes: favoriteQuotes)
                    }
                }
                .navigationTitle("Favoriten")
            }
        }
    }
}

struct FavoritesListView: View {
    let quotes: [Quote]
    
    var body: some View {
        List {
            ForEach(quotes) { quote in
                QuoteRowView(quote: quote)
                    .swipeActions {
                        Button("Unfavorite") {
                            quote.isFavorite = false
                        }
                        .tint(.pink)
                    }
            }
        }
        .listStyle(.plain)
    }
}

struct FavoritesEmptyStateView: View {
    
    var body: some View {
        ContentUnavailableView(
            "Keine Favoriten",
            systemImage: "heart.slash",
            description: Text("Für den ausgewählten Filter gibt es momentan keine Favoriten.")
        )
    }
}

#Preview {
    FavoritesView()
}
