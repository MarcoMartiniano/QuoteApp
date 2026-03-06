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
                    .foregroundStyle(.script)
            }
            .tag(0)
            
            NavigationStack {
                QuoteView()
            }
            .tabItem {
                Label("Zitate", systemImage: "quote.bubble")
                    .foregroundStyle(.script)
            }
            .tag(1)
            
            FavoritesView()
                .tabItem {
                    Label("Favoriten", systemImage: "heart.fill")
                        .foregroundStyle(.script)
                }
                .tag(2)

            PreferencesView()
                .tabItem {
                    Label("Preferences", systemImage: "slider.horizontal.3")
                        .foregroundStyle(.script)
                }
                .tag(3)
            
        }
        .onAppear {
           DataSeeder.seedIfNeeded(context: context)
        }
    }
}
