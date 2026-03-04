//
//  FavoritiesPlannenApp.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import SwiftUI
import SwiftData

@main
struct QuoteApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }.modelContainer(for: [Author.self, Quote.self, CategorySelection.self])
    }
}
