import SwiftUI

struct MeasurementOptionsView: View {
    @Environment(\.dismiss) var dismiss
    var option: MeasurementType
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                HeaderElement(title: option.title, withBackButton: true, withImage: false) {
                    dismiss()
                }
                .frame(height: 70)
                
                if option == .quantity {
                    Button {
                       // Quantity always has one option, so no action needed
                    } label: {
                        Text(option.value.0)
                            .font(FontFamily.Moderustic.medium.swiftUIFont(size: 24))
                            .foregroundColor(.customBrown)
                            .frame(maxWidth: 170)
                            .padding(8)
                            .background(.customYellow)
                            .cornerRadius(30)
                    }
                    .padding(.top, 20)
                } else {
                    HStack(spacing: 15) {
                        Button {
                            selectedIndex = 0
                            saveSelection(index: 0)
                        } label: {
                            Text(option.value.0)
                                .font(FontFamily.Moderustic.medium.swiftUIFont(size: 24))
                                .foregroundColor(selectedIndex == 0 ? .white : .customYellow)
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(selectedIndex == 0 ? .customYellow : .white)
                                .cornerRadius(30)
                        }
                        
                        Button {
                            selectedIndex = 1
                            saveSelection(index: 1)
                        } label: {
                            Text(option.value.1)
                                .font(FontFamily.Moderustic.medium.swiftUIFont(size: 24))
                                .foregroundColor(selectedIndex == 1 ? .white : .customYellow)
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(selectedIndex == 1 ? .customYellow : .white)
                                .cornerRadius(30)
                        }
                    }
                    .padding(.top, 20)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            // Load saved selection from UserDefaults
            selectedIndex = option.selectedUnitIndex
        }
    }
    
    // Method to save selection to UserDefaults
    private func saveSelection(index: Int) {
        switch option {
        case .weight:
            UserDefaults.standard.set(index, forKey: MeasurementType.weightUnitKey)
        case .volume:
            UserDefaults.standard.set(index, forKey: MeasurementType.volumeUnitKey)
        case .quantity:
            break // No need to save for quantity
        }
        
        // Post notification when unit changes
        NotificationCenter.default.post(name: MeasurementType.unitChangedNotification, object: option)
    }
}

#Preview {
    MeasurementOptionsView(option: .weight)
}
