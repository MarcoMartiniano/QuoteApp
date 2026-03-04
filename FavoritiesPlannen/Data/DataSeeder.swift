//
//  aaa.swift
//  Projektwoche1
//
//  Created by Marco Antonio Martiniano on 04.03.26.
//

import SwiftData
import SwiftUI

struct DataSeeder {
    @AppStorage("hasSeededData") private static var hasSeededData: Bool = false
    
    static func seedIfNeeded(context: ModelContext) {
        
        guard hasSeededData == false else { return }
        
        for quote in InitialEntryData.quotes {
            
            let author = Author(name: quote.author?.name ?? "Unbekannt")
            
            let newQuote = Quote(
                text: quote.text,
                isFavorite: quote.isFavorite,
                category: quote.category,
                author: author
            )
            
            context.insert(author)
            context.insert(newQuote)
        }
        
        for category in QuoteCategory.allCases {
            let newSelection = CategorySelection(category: category)
            context.insert(newSelection)
        }
        
        try? context.save()
        
        hasSeededData = true
    }
}
