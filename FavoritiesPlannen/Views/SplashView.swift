import SwiftUI

struct SplashView: View {

    @State private var isActive: Bool = false

    var body: some View {

        ZStack {

            // Background für Splash
            AppBackground()
                .ignoresSafeArea()

            if isActive {

                RootView()

            } else {

                VStack(spacing: 18) {

                    Text("Quote-Craft")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(.black.opacity(0.35))
                        .cornerRadius(16)
                        .padding(.top, 40)

                    Spacer()

                    Image("AppSplashImage")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(width: 300, height: 300)
                        .padding(40)
                     

                    Spacer()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
