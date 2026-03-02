//
//  InitialData.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import Foundation


struct InitiaEntryData {
    static let quote: Quote =
        Quote(text: "Die Grenzen meiner Sprache bedeuten die Grenzen meiner Welt.", isFavorite: true, author: Author(name: "Ludwig Wittgenstein"))
    
    static let quotes: [Quote] = [
        Quote(text: "Die Grenzen meiner Sprache bedeuten die Grenzen meiner Welt.", isFavorite: true, author: Author(name: "Ludwig Wittgenstein")),
        Quote(text: "Wer kämpft, kann verlieren. Wer nicht kämpft, hat schon verloren.", isFavorite: false, author: Author(name: "Bertolt Brecht")),
        Quote(text: "Phantasie ist wichtiger als Wissen, denn Wissen ist begrenzt.", isFavorite: true, author: Author(name: "Albert Einstein"))
    ]
}
