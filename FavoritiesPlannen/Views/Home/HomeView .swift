//
//  HomeView .swift
//  QuoteCraft
//
//  Created by Viacheslav Makhovyk on 02.03.26.
//

import SwiftUI

struct HomeView: View {
    @State private var refresh: Bool = false
    @State private var randomQuote: Quote = Quote(text: "", isFavorite: false)
    @State private var quotes: [Quote] = InitiaEntryData.quotes
    
    var body: some View {
        VStack(spacing: 20) { // Hauptcontainer für die Ansicht
            
            Spacer() // Drückt den Inhalt in die Mitte
            
            // Container für die Zitat-Karte
            VStack(alignment: .leading, spacing: 20) {
                
                Text(randomQuote.text) // Zitattext
                    .font(.title) // Große Schriftart
                    .fontWeight(.medium) // Mittleres Schriftgewicht
                    .italic() // Kursivschrift
                    .foregroundColor(.primary) // Hauptfarbe für Text
                
                Text("- \(String(describing: randomQuote.author?.name))") // Autor des Zitats
                    .font(.headline) // Überschrift-Schriftart
                    .foregroundColor(.secondary) // Sekundärfarbe
                    .frame(maxWidth: .infinity, alignment: .trailing) // Rechtsbündig
                
            }
            .padding(25) // Innenabstand der Karte
            .background(Color(UIColor.secondarySystemBackground)) // Hintergrundfarbe
            .cornerRadius(15) // Abgerundete Ecken
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Schatten für Tiefe (Shadow Effect)
            .padding(.horizontal, 20) // Außenabstand links und rechts
            
            Button{
                randomQuote = quotes.randomElement()!
            } label: {
              Image(systemName: "arrow.clockwise")
                .foregroundStyle(.black)
                .font(.system(size: 40))
            }
            
            Spacer() // Drückt den Inhalt in die Mitte
            
        }.onAppear {
            randomQuote = quotes.randomElement()!
        }
    }
}

#Preview {
    HomeView()
}

