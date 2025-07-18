import SwiftUI

struct FoodView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var consumableService: ConsumableService
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                HeaderElement(title: .foodTitle, withBackButton: true, withImage: true) {
                    dismiss()
                }
                .frame(height: 70)
                
                // Content
                if foodItems.isEmpty {
                    Spacer()
                    
                    Text("No food items added yet")
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(foodItems) { item in
                                FoodItemRow(consumable: item)
                            }
                        }
                        .padding(.top, 20)
                    }
                    .padding(.bottom, 70)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var foodItems: [ConsumableModel] {
        return consumableService.getConsumables(ofType: .food)
    }
}

struct FoodItemRow: View {
    let consumable: ConsumableModel
    
    var body: some View {
        NavigationLink(destination: DetailedConsumableView(consumable: consumable)) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(consumable.name)
                        .font(FontFamily.Moderustic.regular.swiftUIFont(size: 16))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                Text(consumable.remainingText)
                    .font(FontFamily.Moderustic.regular.swiftUIFont(size: 16))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.black.opacity(0.2))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FoodView()
        .environmentObject(ConsumableService())
}
