//
//  RootView.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 02.03.26.
//

import SwiftUI

struct RootView: View {
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
        }
    }
}
