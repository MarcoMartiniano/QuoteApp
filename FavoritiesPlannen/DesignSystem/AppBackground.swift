import SwiftUI

struct AppBackground: View {

    var body: some View {
        LinearGradient(
            colors: [
                Color.blue.opacity(0.6),
                Color.purple.opacity(0.4),
                Color.white
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
