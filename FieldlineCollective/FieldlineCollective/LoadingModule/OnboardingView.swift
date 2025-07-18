import SwiftUI

struct OnboardingView: View {
    @State private var selection = 0
    @State private var showMainView = false
    @AppStorage("hasSeenTutorial") private var hasSeenTutorial = false
    @EnvironmentObject private var animalService: AnimalService
    
    var body: some View {
        ZStack {
            if showMainView {
                MainView()
                    .environmentObject(animalService)
            } else {
                Color.customDark
                    .ignoresSafeArea()
                
                TabView(selection: $selection) {
                    OnboardingPageView(
                        title: .onbTitle1,
                        pageBody: .onbBody1,
                        buttonTitle: "NEXT",
                        buttonAction: { selection = 1 }
                    )
                    .tag(0)
                    
                    OnboardingPageView(
                        title: .onbTitle2,
                        pageBody: .onbBody2,
                        buttonTitle: "START NOW",
                        buttonAction: {
                            hasSeenTutorial = true
                            showMainView = true
                        }
                    )
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AnimalService())
}


struct OnboardingPageView: View {
    let title: ImageResource
    let pageBody: ImageResource
    let buttonTitle: String
    let buttonAction: () -> Void
    
    var body: some View {
        VStack {
            Image(title)
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Image(pageBody)
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Image(.eggsImg)
                .resizable()
                .frame(width: 200, height: 208)
            
            
            Spacer()
            
            BaseButton(buttonTitle: buttonTitle, buttonAction: buttonAction)
        }
        .padding()
    }
}
