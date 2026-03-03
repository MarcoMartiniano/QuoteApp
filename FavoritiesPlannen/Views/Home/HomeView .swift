//
//  HomeView .swift
//  QuoteCraft
//
//  Created by Viacheslav Makhovyk on 02.03.26.
//

import SwiftUI
import SwiftData

// Hauptansicht für die App
struct HomeView: View {
    // Holt alle Zitate aus der Datenbank
    @Query private var allQuotes: [Quote]
    
    // Zustände der Ansicht
    @State private var randomQuote: Quote? = nil
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                ZStack(alignment: .topTrailing) {
                    Image("DreamWorld")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)

                    HStack {
                        Spacer()
                        Button{
                            
                        } label: {
                          Image(systemName: "square.and.arrow.up.fill")
                            .foregroundStyle(.black)
                            .frame(width: 30 , height: 30)
                            .background(Color.white)
                            .cornerRadius(10)
                        }.padding()
                    }
                }.padding()
                
                // Container für die Zitat-Karte
                VStack(alignment: .leading, spacing: 20) {
                    // Zitattext anzeigen
                    Text(randomQuote?.text ?? "Keine Zitate vorhanden")
                        .font(.title) // Große Schriftart
                        .fontWeight(.medium) // Mittleres Schriftgewicht
                        .italic() // Kursivschrift
                        .foregroundColor(.primary) // Hauptfarbe
                    
                    // Autor anzeigen
                    Text("- \(randomQuote?.author?.name ?? "Unbekannt")")
                        .font(.headline) // Überschrift-Schriftart
                        .foregroundColor(.secondary) // Sekundärfarbe
                        .frame(maxWidth: .infinity, alignment: .trailing) // Rechtsbündig
                    
                }
                .padding(25) // Innenabstand
                .background(Color(UIColor.secondarySystemBackground)) // Hintergrund
                .cornerRadius(15) // Abgerundete Ecken
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Schadoweffekt
                .padding(.horizontal, 20) // Außenabstand
                
                Button {
                pickRandomQuote()
                    
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundStyle(.black)
                        .font(.system(size: 40))
                }
                
                Spacer()
            }
            .navigationTitle("QuoteCraft") // Titel
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddSheet = true // Sheet öffnen
                    }) {
                        Image(systemName: "plus") // Plus-Icon
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                // Aufruf der neuen Ansicht
                AddQuoteSheetView()
            }
            .onAppear {
                // Beim Start ein zufälliges Zitat wählen
                pickRandomQuote()
            }
        }
    }
    
    // Funktion für zufälliges Zitat
    private func pickRandomQuote() {
        if let random = allQuotes.randomElement() {
            randomQuote = random
        }
    }
    
}

// Ansicht für das Pop-up
struct AddQuoteSheetView: View {
    @Environment(\.dismiss) var dismiss // Zum Schließen
    @Environment(\.modelContext) private var modelContext // Datenbank-Kontext
    
    @State private var quoteText = "" // Textfeld für Zitat
    @State private var authorText = "" // Textfeld für Autor
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Neues Zitat erstellen")) { // Abschnitt
                    TextField("Zitat eingeben...", text: $quoteText)
                    TextField("Autor eingeben...", text: $authorText)
                }
            }
            .navigationTitle("Zitat hinzufügen") // Titel
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Abbrechen") { // Abbrechen-Button
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Speichern") { // Speichern-Button
                        
                        // 1. Neuen Autor erstellen
                        let newAuthor = Author(name: authorText)
                        
                        // 2. Neues Zitat erstellen und Autor verknüpfen
                        let newQuote = Quote(text: quoteText, isFavorite: false, category: .none, author: newAuthor)
                        
                        // 3. In die Datenbank einfügen
                        modelContext.insert(newAuthor)
                        modelContext.insert(newQuote)
                        
                        // 4. Sheet schließen
                        dismiss()
                    }
                    // Deaktivieren, wenn Felder leer sind
                    .disabled(quoteText.isEmpty || authorText.isEmpty)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
