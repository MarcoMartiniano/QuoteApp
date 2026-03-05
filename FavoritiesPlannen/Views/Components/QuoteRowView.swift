//
//  QuoteRowView.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 05.03.26.
//

import SwiftUI

struct QuoteRowView: View {
    var quote: Quote
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            QuoteIconView(category: quote.category)

            QuoteContentView(
                author: quote.author?.name ?? "Unbekannt",
                text: quote.text
            )
            
            Spacer()
            
            FavoriteButton(quote: quote)
        }
        .padding(.vertical, 8)
    }
}


// MARK: - Category Icon
private struct QuoteIconView: View {
    
    let category: QuoteCategory
    
    var body: some View {
        Image(systemName: category.sfSymbol)
            .font(.system(size: 40))
            .foregroundColor(.blue)
    }
}


// MARK: - Quote Content
private struct QuoteContentView: View {
    
    let author: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(author)
                .font(.headline)
            
            Text(text)
                .font(.callout)
                .italic()
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Favorite Button
private struct FavoriteButton: View {
    
    var quote: Quote
    @State private var bounce = false
    
    var body: some View {
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
}

#Preview(traits: .sizeThatFitsLayout) {
    QuoteRowView(quote: InitialEntryData.quotes.first!)
}
