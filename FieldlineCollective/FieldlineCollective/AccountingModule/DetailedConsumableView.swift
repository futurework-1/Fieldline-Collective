import SwiftUI

struct DetailedConsumableView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var consumableService: ConsumableService
    let consumable: ConsumableModel
    
    // Get current consumable from service to reflect updates
    private var currentConsumable: ConsumableModel {
        consumableService.consumables.first { $0.id == consumable.id } ?? consumable
    }
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HeaderElement(title: nil, stringTitle: consumable.name, withBackButton: true, withImage: false) {
                    dismiss()
                }
                .frame(height: 100)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Remaining section
                        detailSection(title: "Remaining", value: currentConsumable.remainingText)
                        
                        // Expiry Date section
                        if let expiryDate = currentConsumable.expiryDate {
                            detailSection(title: "Expiry Date", value: formatDate(expiryDate))
                        }
                        
                        // Last action section
                        if let lastAction = currentConsumable.lastAction {
                            detailSection(title: "Last action", value: lastAction.displayText)
                        }
                        
                        // Image
                        Image(.eggsImg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                        
                        Spacer(minLength: 120) // Space for buttons
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                
                // Bottom buttons
                VStack(spacing: 12) {
                    // Use button
                    NavigationLink(destination: UseAddConsumableView(consumable: consumable, actionType: .use)) {
                        Text("Use")
                            .font(FontFamily.Moderustic.medium.swiftUIFont(size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.customBrown)
                            .cornerRadius(25)
                    }
                    
                    // Add button
                    NavigationLink(destination: UseAddConsumableView(consumable: consumable, actionType: .add)) {
                        Text("Add")
                            .font(FontFamily.Moderustic.medium.swiftUIFont(size: 18))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.customYellow)
                            .cornerRadius(25)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func detailSection(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                .foregroundColor(.customYellow)
                .underline()
            
            Text(value)
                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 16))
                .foregroundColor(.white)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationView {
        DetailedConsumableView(
            consumable: ConsumableModel(
                name: "Crushed wheat",
                type: .food,
                currentQuantity: 15,
                totalQuantity: 50,
                unit: "kg",
                expiryDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 12)),
                lastAction: LastAction(
                    action: "Used",
                    description: "morning feeding",
                    date: Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 29)) ?? Date()
                )
            )
        )
        .environmentObject(ConsumableService())
    }
} 
