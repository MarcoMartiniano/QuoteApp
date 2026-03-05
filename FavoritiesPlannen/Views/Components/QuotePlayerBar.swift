//
//  aa.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 05.03.26.
//

import SwiftUI

struct QuotePlayerBar: View {
    
    let onStart: () -> Void
    let onPause: () -> Void
    let onResume: () -> Void
    let onRefresh: () -> Void
    
    var body: some View {
        HStack(spacing: 40) {
            
            playerButton(systemImage: "play.fill", title: "Start", action: onStart)
            playerButton(systemImage: "pause.fill", title: "Pause", action: onPause)
            playerButton(systemImage: "play.circle.fill", title: "Weiter", action: onResume)
            playerButton(systemImage: "arrow.clockwise", title: "Neu", action: onRefresh)
            
        }
        .foregroundStyle(.black)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
    
    
    @ViewBuilder
    private func playerButton(systemImage: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: systemImage)
                    .font(.system(size: 24))
                Text(title)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    QuotePlayerBar(onStart: {}, onPause: {}, onResume: {}, onRefresh: {})
}
