//
//  QuoteCategory.swift
//  FavoritiesPlannen
//
//  Created by Daniel Bartlsberger on 03.03.26.
//

import Foundation

enum QuoteCategory: String, CaseIterable, Identifiable, Codable {
    
    case none
    case motivation
    case leben
    case liebe
    case erfolg
    case humor
    case weisheit
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .none: return "Keine Kategorie"
        case .motivation: return "Motivation"
        case .leben: return "Leben"
        case .liebe: return "Liebe"
        case .erfolg: return "Erfolg"
        case .humor: return "Humor"
        case .weisheit: return "Weisheit"
        }
    }
    
    var sfSymbol: String {
        switch self {
        case .none: return "questionmark.circle"
        case .motivation: return "flame.fill"
        case .leben: return "leaf.fill"
        case .liebe: return "heart.fill"
        case .erfolg: return "trophy.fill"
        case .humor: return "theatermasks.fill"
        case .weisheit: return "lightbulb.fill"
        }
    }
    
    var image: String {
        switch self {
        case .none: return "DefaultImage"
        case .motivation: return "MotivationImage"
        case .leben: return "LebenImage"
        case .liebe: return "LiebeImage"
        case .erfolg: return "ErfolgImage"
        case .humor: return "HumorImage"
        case .weisheit: return "WeisheitImage"
        }
    }
}

