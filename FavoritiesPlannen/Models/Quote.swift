//
//  a.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import Foundation
import SwiftData

 @Model
 class Quote {
     
     var id: UUID
     var text: String
     var isFavorite: Bool
     var category: QuoteCategory
     
     @Relationship(inverse: \Author.quotes)
     var author: Author?
     
     init(
         id: UUID = UUID(),
         text: String,
         isFavorite: Bool = false,
         category: QuoteCategory,
         author: Author? = nil
     ) {
         self.id = id
         self.text = text
         self.isFavorite = isFavorite
         self.category = category
         self.author = author
     }
 }

