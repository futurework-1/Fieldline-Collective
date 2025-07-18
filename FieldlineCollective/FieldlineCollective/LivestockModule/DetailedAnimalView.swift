import SwiftUI

struct DetailedAnimalView: View {
    @Environment(\.dismiss) private var dismiss
    var animal: AnimalModel
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HeaderElement(title: nil, stringTitle: animal.name, withBackButton: true, withImage: false) {
                    dismiss()
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // View section
                        detailSection(title: "View", value: animal.type.rawValue)
                        
                        // Date of Birth section
                        detailSection(title: "Date Of Birth", value: animal.birthDate.formatted(date: .abbreviated, time: .omitted))
                        
                        // Age section
                        detailSection(title: "Age", value: animal.age.rawValue)
                        
                        // Condition section
                        detailSection(title: "Condition", value: animal.condition.rawValue == "underSurveillance" ? "Under observation" : animal.condition.rawValue)
                        
                        // Productivity section
                        detailSection(title: "Productivity", value: animal.productivity.isEmpty ? "—" : animal.productivity)
                        
                        // Notes section
                        detailSection(title: "Notes", value: animal.notes.isEmpty ? "—" : animal.notes)
                        
                        // Feature section
                        detailSection(title: "Feature", value: animal.feature.isEmpty ? "—" : animal.feature)
                        
                        // Image
                        Image(.eggsImg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                    }
                }
            }
            .padding(.horizontal)
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
}

#Preview {
    NavigationView {
        DetailedAnimalView(animal: AnimalModel(
            name: "Busya",
            type: .pig,
            condition: .underSurveillance,
            age: .young
        ))
    }
}
