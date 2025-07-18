import SwiftUI

struct MeasurementView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                HeaderElement(title: .measurementTitle, withBackButton: true, withImage: false) {
                    dismiss()
                }
                .frame(height: 100)
                
                NavigationLink(destination: MeasurementOptionsView(option: .weight)) {
                    Text("Weight")
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
                
                NavigationLink(destination: MeasurementOptionsView(option: .volume)) {
                    Text("Volume")
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
                
                NavigationLink(destination: MeasurementOptionsView(option: .quantity)) {
                    Text("Quantity")
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
    MeasurementView()
}
