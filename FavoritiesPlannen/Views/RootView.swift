//
//  RootView.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import SwiftUI

struct RootView: View {
    @Environment(\.modelContext) private var context
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            NavigationStack {
                QuoteView()
            }
            .tabItem {
                Label("Zitate", systemImage: "quote.bubble")
            }
            .tag(1)
            
            FavoritesView()
                .tabItem {
                    Label("Favoriten", systemImage: "heart.fill")
                }
                .tag(2)

            PreferencesView()
                .tabItem {
                    Label("Preferences", systemImage: "slider.horizontal.3")
                }
                .tag(3)
            
        }
        .onAppear {
           DataSeeder.seedIfNeeded(context: context)
        }
    }
}
