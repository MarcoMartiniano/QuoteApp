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
            VStack(spacing: 30) {
                
                ZStack(alignment: .topTrailing) {
                    
                    let image = randomQuote?.category.image.isEmpty == false
                    ? randomQuote!.category.image
                    : QuoteCategory.none.image
                    HStack {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .padding(.top, 10)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    }
                    HStack {
                        Spacer()
                        
                        Button {
                            showingShareSheet.toggle()
                        } label: {
                            Image(systemName: "square.and.arrow.up.fill")
                                .foregroundStyle(.black)
                                .font(.system(size: 24))
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }.padding(.top, 6)
                
                // Container für die Zitat-Karte
                VStack(alignment: .leading, spacing: 20) {
                    // ❗️NEU: HStack um Text und Herz-Button zu trennen, damit sie sich nicht überlappen
                    HStack(alignment: .top) {
                        
                        Text(randomQuote?.text ?? "Keine Zitate vorhanden")
                            .font(.title)
                            .fontWeight(.medium)
                            .italic()
                            .foregroundColor(.primary)
                        
                        Spacer(minLength: 15) // Garantiert einen Mindestabstand
                        
                        if randomQuote != nil {
                            Button {
                                randomQuote?.isFavorite.toggle()
                            } label: {
                                Image(systemName: randomQuote?.isFavorite == true ? "heart.fill" : "heart")
                                    .foregroundColor(randomQuote?.isFavorite == true ? .red : .gray)
                                    .font(.title2)
                            }
                        }
                    }
                    // Autor anzeigen
                    Text("- \(randomQuote?.author?.name ?? "Unbekannt")")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(25)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)
            
                // PLAYER BAR
                QuotePlayerBar(
                    onStart: { startQuotes() },
                    onPause: { pauseQuotes() },
                    onRefresh: { refreshQuote() }
                )
                
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

struct ShareQuoteSheetView: View {
    let selectedItem: Quote?
    
    var body: some View {
        if let item = selectedItem {
            let image = selectedItem?.category.image.isEmpty == false ? selectedItem!.category.image : QuoteCategory.none.image
            VStack {
                HStack {
                    Spacer()
                    ShareLink(
                        item: item.category.image,
                        subject: Text("Zitat teilen"),
                        message: Text("Was sagst du dazu?"),
                        preview: SharePreview(
                            "Zitater",
                            image: Image("App-Logo")
                        )
                    ) {
                        Label("", systemImage: "square.and.arrow.up.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(.blue)
                    }
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 6) {
                        Text(item.text)
                            .font(.title2)
                        HStack{
                            Spacer()
                            Text(item.author?.name ?? "Author unbekannt")
                                .font(.system(size: 16))
                                .foregroundStyle(.gray)
                                .italic()
                        }
                        
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct AddQuoteSheetView: View {
    @Environment(\.dismiss) var dismiss // Zum Schließen
    @Environment(\.modelContext) private var modelContext // Datenbank-Kontext
    
    @State private var quoteText = ""
    @State private var authorText = ""
    
    @State private var selectedCategory: QuoteCategory = .motivation
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Neues Zitat erstellen")) {
                    TextField("Zitat eingeben...", text: $quoteText)
                    TextField("Autor eingeben...", text: $authorText)
                }
                
                Section(header: Text("Kategorie auswählen")) {
                    Picker("Kategorie", selection: $selectedCategory) {
                        // Durchlaufen aller Kategorien
                        ForEach(QuoteCategory.allCases, id: \.self) { category in
                            HStack {
                                Image(systemName: "\(category.sfSymbol)")
                                Text(category.rawValue.capitalized).tag(category)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Zitat hinzufügen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Speichern") {
                        let newAuthor = Author(name: authorText)
                        
                        let newQuote = Quote(text: quoteText, isFavorite: false, category: selectedCategory, author: newAuthor)
                        
                        modelContext.insert(newAuthor)
                        modelContext.insert(newQuote)
                        
                        dismiss()
                    }
                    .disabled(quoteText.isEmpty || authorText.isEmpty) // Button deaktivieren
                }
            }
        }
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
