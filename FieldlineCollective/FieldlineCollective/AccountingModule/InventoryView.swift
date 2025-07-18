import SwiftUI

struct InventoryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var consumableService: ConsumableService
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                HeaderElement(title: .inventoryTitle, withBackButton: true, withImage: true) {
                    dismiss()
                }
                .frame(height: 70)
                
                // Content
                if inventoryItems.isEmpty {
                    Spacer()
                    
                    Text("No inventory items added yet")
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(inventoryItems) { item in
                                InventoryItemRow(consumable: item)
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
    
    private var inventoryItems: [ConsumableModel] {
        return consumableService.getConsumables(ofType: .inventory)
    }
}

struct InventoryItemRow: View {
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
    NavigationView {
        InventoryView()
            .environmentObject(ConsumableService())
    }
}
