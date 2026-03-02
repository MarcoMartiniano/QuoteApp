//
//  a.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import Foundation
import SwiftData

@Model
class Quote: Identifiable {
    var id: UUID = UUID()
    var text: String
    var isFavorite: Bool
    
    @Relationship(inverse: \Author.quotes)
    var author: Author?  // Um autor por citação, facilita
    
    init(id: UUID = UUID(), text: String, isFavorite: Bool = false, author: Author? = nil) {
        self.id = id
        self.text = text
        self.isFavorite = isFavorite
        self.author = author
    }
    
}
