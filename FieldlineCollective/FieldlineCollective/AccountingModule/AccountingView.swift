import SwiftUI

struct AccountingView: View {
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                HeaderElement(title: .accountingTitle, withBackButton: false, withImage: false, backButtonAction: nil)
                
                NavigationLink(destination: FoodView()) {
                    Text("Food")
                        .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: InventoryView()) {
                    Text("Inventory")
                        .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: ConsumablesView()) {
                    Text("Consumables")
                        .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: SeedsView()) {
                    Text("Seeds")
                        .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AccountingView()
}
