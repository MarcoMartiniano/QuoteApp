//
//  CategorySelection.swift
//  Projektwoche1
//
//  Created by Marco Antonio Martiniano on 04.03.26.
//

import SwiftData
import Foundation

@Model
class CategorySelection {
    var id: UUID
    var category: QuoteCategory
    var isSelected: Bool
    
    init( id: UUID = UUID() ,category: QuoteCategory, isSelected: Bool = true) {
        self.id = id
        self.category = category
        self.isSelected = isSelected
    }
}
