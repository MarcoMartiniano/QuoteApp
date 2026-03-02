//
//  Author.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import Foundation
import SwiftData

@Model
class Author: Identifiable {
    var id: UUID = UUID()
    var name: String
    
    var quotes: [Quote] = []
    
    init(id: UUID = UUID(), name: String, quotes: [Quote] = []) {
        self.id = id
        self.name = name
        self.quotes = quotes
    }
}
