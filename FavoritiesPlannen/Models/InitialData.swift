//
//  InitialData.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import Foundation

struct InitialEntryData {
    
    static let quotes: [Quote] = [
        Quote(
            text: "Erfolg beginnt da, wo Ausreden enden.",
            isFavorite: false,
            category: .erfolg, author: Author(name: "Thomas Berger")
        ),
        Quote(
            text: "Du musst nicht perfekt sein. Du musst nur anfangen.",
            isFavorite: false,
            category: .motivation, author: Author(name: "Unbekannt")
        ),
        Quote(
            text: "Jeder kleine Schritt zählt – auch wenn ihn niemand sieht.",
            isFavorite: false,
            category: .leben, author: Author(name: "Marie Winter")
        ),
        Quote(
            text: "Dein Mut entscheidet, nicht deine Angst.",
            isFavorite: false,
            category: .motivation, author: Author(name: "Clara Neumann")
        ),
        Quote(
            text: "Nicht jeder Tag ist gut – aber in jedem Tag steckt etwas Gutes.",
            isFavorite: false,
            category: .leben, author: Author(name: "Unbekannt")
        ),
        Quote(
            text: "Ein freundliches Wort kann ein ganzes Herz verändern.",
            isFavorite: false,
            category: .weisheit, author: Author(name: "Mutter Teresa")
        ),
        Quote(
            text: "Liebe ist die Sprache, die jeder versteht.",
            isFavorite: false,
            category: .liebe, author: Author(name: "Friedrich Schiller")
        ),
        Quote(
            text: "Disziplin schlägt Motivation, wenn Motivation nachlässt.",
            isFavorite: false,
            category: .motivation, author: Author(name: "David Albrecht")
        ),
        Quote(
            text: "Träume funktionieren nur, wenn du arbeitest.",
            isFavorite: false,
            category: .erfolg, author: Author(name: "Paula Schneider")
        ),
        Quote(
            text: "Große Ziele brauchen Geduld – und täglichen Einsatz.",
            isFavorite: false,
            category: .erfolg, author: Author(name: "Anna Weber")
        ),
        Quote(
            text: "Humor ist, wenn man trotzdem lacht.",
            isFavorite: false,
            category: .humor,
            author: Author(name: "Karl Valentin")
        ),
        Quote(
            text: "Manchmal ist einfach nichts zu sagen die beste Lösung.",
            isFavorite: false,
            category: .none,
            author: Author(name: "Unbekannt")
        )
    ]
}
