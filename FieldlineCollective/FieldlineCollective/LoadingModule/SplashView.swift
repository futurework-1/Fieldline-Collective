import SwiftUI

struct SplashView: View {
    @State private var isLoading = true
    @State private var rotation = 0.0
    @EnvironmentObject private var animalService: AnimalService
    
    @AppStorage("hasSeenTutorial") private var hasSeenTutorial = false
    
    var body: some View {
        if isLoading {
            ZStack {
                Color.customDark
                    .ignoresSafeArea()
                
                VStack {
                    Image(.loadingTitle)
                        .padding(.top, 70)
                    Spacer()
                    Image(.eggsImg)
                    Spacer()
                    Image(.loadingCircle)
                        .rotationEffect(.degrees(rotation))
                        .onAppear {
                            withAnimation(
                                Animation.linear(duration: 3.0)
                                    .repeatForever(autoreverses: false)
                            ) {
                                rotation = 360
                            }
                        }
                        .padding(.bottom, 70)
                }
                .padding(.horizontal)
            }
            .onReceive(NotificationCenter.default.publisher(for: .splashTransition)) { _ in
                withAnimation {
                    self.isLoading = false
                }
            }

        } else if !hasSeenTutorial {
            OnboardingView()
                .environmentObject(animalService)
        } else {
            MainView()
                .environmentObject(animalService)
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(AnimalService())
}
