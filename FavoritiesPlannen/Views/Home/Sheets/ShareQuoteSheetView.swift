//
//  ShareQuoteSheetView.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 05.03.26.
//

import SwiftUI

struct ShareQuoteSheetView: View {
    
    let selectedItem: Quote?
    
    var body: some View {
        if let item = selectedItem {
            
            let imageName = item.category.image.isEmpty
                ? QuoteCategory.none.image
                : item.category.image
            
            VStack {
                
                ShareHeaderView(imageName: imageName)
                
                Spacer()
                
                ShareQuoteContentView(
                    imageName: imageName,
                    text: item.text,
                    author: item.author?.name ?? "Author unbekannt"
                )
                
                Spacer()
            }
            .padding()
        }
    }
}


// MARK: - Share Header
private struct ShareHeaderView: View {
    
    let imageName: String
    
    var body: some View {
        HStack {
            Spacer()
            
            ShareLink(
                item: imageName,
                subject: Text("Zitat teilen"),
                message: Text("Was sagst du dazu?"),
                preview: SharePreview(
                    "Zitater",
                    image: Image("App-Logo")
                )
            ) {
                Label("", systemImage: "square.and.arrow.up.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(.blue)
            }
        }
    }
}


// MARK: - Quote Content
private struct ShareQuoteContentView: View {
    
    let imageName: String
    let text: String
    let author: String
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            
            VStack(spacing: 6) {
                
                Text(text)
                    .font(.title2)
                
                HStack {
                    Spacer()
                    
                    Text(author)
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                        .italic()
                }
            }
        }
    }
}

#Preview {
    ShareQuoteSheetView(selectedItem: InitialEntryData.quotes.first)
}
