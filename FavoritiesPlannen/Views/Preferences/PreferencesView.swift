//
//  PreferencesView.swift
//  FavoritiesPlannen
//
//  Created by Daniel Bartlsberger on 04.03.26.
//

import SwiftUI
import SwiftData

struct PreferencesView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var categories: [CategorySelection]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories, id: \.id) { category in
                    PreferencesRowView(
                        title: category.category.displayName,
                        isSelected: Binding<Bool>(
                            get: { category.isSelected },
                            set: { newValue in
                                category.isSelected = newValue
                                try? context.save()
                            }
                        )
                    )
                }

            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .listStyle(.plain)
            .navigationTitle("Preferences")
        }
    }
}

struct PreferencesRowView: View {
    let title: String
    @Binding var isSelected: Bool
    var body: some View {

        HStack(alignment: .center, spacing: 12) {

            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Spacer()

            Toggle("", isOn: $isSelected)
                .labelsHidden()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.75))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.white.opacity(0.45), lineWidth: 1)
        )
        .shadow(radius: 6)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
