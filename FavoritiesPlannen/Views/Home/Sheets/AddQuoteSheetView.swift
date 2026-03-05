//
//  AddQuoteSheetView.swift
//  FavoritiesPlannen
//
//  Created by Marco Antonio Martiniano on 05.03.26.
//

import SwiftUI
import SwiftData

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
    AddQuoteSheetView()
}
