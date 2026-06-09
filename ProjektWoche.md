# Week 5 - Group Projektwoche

# QuoteCraft

## Projektübersicht

QuoteCraft ist eine einfache Zitat-App, die im Rahmen eines Gruppenprojekts entwickelt wurde.

Die App zeigt zufällige Zitate inklusive Autor:in an und ermöglicht es Usern, neue Zitate zu laden sowie Favoriten zu speichern.

Ziel des Projekts war es, den Umgang mit SwiftUI, State Management und SwiftData zu vertiefen.

---

## Hauptfunktionen

### Zitat anzeigen

Beim Start der App wird automatisch ein zufälliges Zitat angezeigt.

Zusätzlich kann der User jederzeit ein neues Zitat laden.

```swift id="q1a8z2"
Text(quote.text)
Text(quote.author)
```

---

### Neues Zitat laden

Ein Button ermöglicht das Aktualisieren des angezeigten Zitats.

```swift id="b7k3lm"
Button("Neues Zitat") {
    viewModel.fetchQuote()
}
```

Dadurch wird ein neues zufälliges Zitat geladen.

---

### Favoriten hinzufügen

User können ein Zitat als Favorit markieren.

Diese Funktion erlaubt es, interessante Zitate dauerhaft zu speichern.

```swift id="f4x9pq"
Button {
    viewModel.addFavorite(quote)
} label: {
    Image(systemName: "heart")
}
```

---

### Favoriten anzeigen (Sheet)

Die gespeicherten Favoriten werden in einem Sheet angezeigt.

```swift id="s8n2vd"
.sheet(isPresented: $showFavorites) {
    FavoritesView()
}
```

---

### Favoriten speichern (SwiftData)

Favoriten werden persistent mit SwiftData gespeichert.

Dadurch bleiben sie auch nach einem App-Neustart erhalten.

```swift id="d6r1kx"
@Model
class FavoriteQuote {
    var id: String
    var text: String
    var author: String

    init(id: String, text: String, author: String) {
        self.id = id
        self.text = text
        self.author = author
    }
}
```

---

### Favoriten löschen

User können einzelne Favoriten wieder entfernen.

```swift id="x2m9rt"
modelContext.delete(favorite)
```

---

## App-Verhalten

* Beim Start wird automatisch ein neues Zitat geladen
* Der User kann jederzeit ein neues Zitat anfordern
* Favoriten werden lokal gespeichert
* Favoriten können angezeigt und gelöscht werden

---

## Optionale Features

Im Projekt wurden zusätzlich optionale Features umgesetzt bzw. vorbereitet:

### Kategorien

Zitate können Kategorien zugeordnet werden, um sie besser zu organisieren.

### Hintergrundgestaltung

Zitate können mit Hintergrundfarben oder Bildern visuell aufgewertet werden.

### Teilen-Funktion

Zitate können als Bild exportiert und geteilt werden.

---

## Fazit

QuoteCraft ist ein kleines, aber vollständiges SwiftUI-Projekt, das folgende Konzepte kombiniert:

* SwiftUI Views und State Management
* API-Integration
* SwiftData Persistenz
* Sheets und Navigation
* Benutzerinteraktionen (Favorisieren, Löschen)

Das Projekt eignet sich als Grundlage für eine weiterführende Ausbau-App im Portfolio.
