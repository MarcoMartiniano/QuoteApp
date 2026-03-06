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
    @Query private var selectedCategories: [CategorySelection]
    
    @State private var selectedItem: Quote?
    
    // Zustände der Ansicht
    @State private var randomQuote: Quote? = nil
    @State private var showingAddSheet = false
    @State private var showingShareSheet = false
    
    // PLAYER STATES
    @State private var timer: Timer? = nil
    @State private var isPlaying = false
    
    var body: some View {
        NavigationView {
            ZStack
            {
                Color(.colorBlue)
                    .ignoresSafeArea(.all)
                VStack(spacing: 30) {
                    
                    QuoteImageHeaderView(
                        quote: randomQuote,
                        onShareTap: { showingShareSheet.toggle() }
                    )
                    .padding(.top, 6)
                    
                    // Container für die Zitat-Karte
                    QuoteCardView(quote: randomQuote)
                    
                    if randomQuote != nil {
                        // PLAYER BAR
                        QuotePlayerBar(
                            onStart: { startQuotes() },
                            onPause: { pauseQuotes() },
                            onRefresh: { refreshQuote() }
                        )
                    }
                    
                    Spacer()
                }
                .navigationTitle("Quote Craft")
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddSheet = true  // Sheet öffnen
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                
                .sheet(isPresented: $showingAddSheet) {
                    // Aufruf der neuen Ansicht
                    AddQuoteSheetView()
                }
                
                .sheet(isPresented: $showingShareSheet) {
                    ShareQuoteSheetView(selectedItem: selectedItem)
                        .presentationDetents([.fraction(0.6)])
                        .presentationDragIndicator(.visible)
                }
                
                .onAppear {
                    // Beim Start ein zufälliges Zitat wählen
                    pickRandomQuote()
                }
            }
        }
    }
    
    // Funktion für zufälliges Zitat
    private func pickRandomQuote() {
        
        let activeCategories = selectedCategories
            .filter { $0.isSelected }
            .map { $0.category }
        
        let filteredQuotes = allQuotes.filter {
            activeCategories.contains($0.category)
        }
        
        randomQuote = filteredQuotes.randomElement()
        selectedItem = randomQuote
    }
    
    
    // PLAYER FUNCTIONS
    
    private func startQuotes() {
        isPlaying = true
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            pickRandomQuote()
        }
    }
    
    private func pauseQuotes() {
        isPlaying = false
        timer?.invalidate()
    }
    
    private func refreshQuote() {
        pauseQuotes()
        pickRandomQuote()
    }
}


// MARK: - Header mit Bild + Share Button
private struct QuoteImageHeaderView: View {
    
    let quote: Quote?
    let onShareTap: () -> Void
    
    var body: some View {
        
        let image = quote?.category.image.isEmpty == false
        ? quote!.category.image
        : QuoteCategory.none.image
        
        ZStack(alignment: .topTrailing) {
            
            Image(image)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, maxHeight: 200)
            
            Button {
                onShareTap()
            } label: {
                Image(systemName: "square.and.arrow.up.fill")
                    .foregroundStyle(.script)
                    .font(.system(size: 24))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}


// MARK: - Zitat Karte
private struct QuoteCardView: View {
    
    let quote: Quote?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            // ❗️NEU: HStack um Text und Herz-Button zu trennen, damit sie sich nicht überlappen
            HStack(alignment: .top) {
                
                Text(quote?.text ?? "Keine Zitate vorhanden")
                    .font(.title)
                    .fontWeight(.medium)
                    .italic()
                    .foregroundColor(.primary)
                
                Spacer(minLength: 15)
                
                if quote != nil {
                    Button {
                        quote?.isFavorite.toggle()
                    } label: {
                        Image(systemName: quote?.isFavorite == true ? "heart.fill" : "heart")
                            .foregroundColor(quote?.isFavorite == true ? .red : .gray)
                            .font(.title2)
                    }
                }
            }
            
            // Autor anzeigen
            Text("- \(quote?.author?.name ?? "Unbekannt")")
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(25)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [Author.self, Quote.self], inMemory: true)
}

#Preview("ShareQuoteSheetView") {
    ShareQuoteSheetView(
        selectedItem: InitialEntryData.quotes.first
    )
}
