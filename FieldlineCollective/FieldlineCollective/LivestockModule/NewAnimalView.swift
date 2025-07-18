import SwiftUI

struct NewAnimalView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var animalService: AnimalService
    
    @State private var animal = AnimalModel()
    @State private var showDatePicker = false
    @State private var showTypeDropdown = false
    @State private var showConditionDropdown = false
    @State private var showAgeDropdown = false
    @State private var showProductivityDropdown = false
    
    // Predefined productivity options
    private let productivityOptions = [
        "3 eggs/week",
        "28 liters/day",
        "—",
        "4 eggs/week",
        "3.5 liters/day"
    ]
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HeaderElement(title: .newAnimalTitle, withBackButton: true, withImage: false) {
                    dismiss()
                }
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Name field
                        TextField("Name", text: $animal.name)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.customYellow)
                            .accentColor(.customYellow)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.customYellow, lineWidth: 1)
                            )
                            .placeholder(when: animal.name.isEmpty) {
                                Text("Name")
                                    .foregroundColor(.customYellow.opacity(0.7))
                                    .padding(.leading, 16)
                            }
                        
                        // Animal type dropdown
                        VStack {
                            Button {
                                withAnimation {
                                    showTypeDropdown.toggle()
                                    showDatePicker = false
                                    showConditionDropdown = false
                                    showAgeDropdown = false
                                    showProductivityDropdown = false
                                }
                            } label: {
                                HStack {
                                    Text(animal.type.rawValue.isEmpty ? "View" : animal.type.rawValue)
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.customYellow)
                                        .rotationEffect(.degrees(showTypeDropdown ? 90 : 0))
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showTypeDropdown {
                                VStack(spacing: 0) {
                                    ForEach(AnimalType.allCases, id: \.self) { type in
                                        Button {
                                            animal.type = type
                                            withAnimation {
                                                showTypeDropdown = false
                                            }
                                        } label: {
                                            HStack {
                                                Text(type.rawValue)
                                                    .foregroundColor(.customYellow)
                                                Spacer()
                                            }
                                            .padding()
                                            .background(Color.black.opacity(0.3))
                                        }
                                        Divider()
                                            .background(Color.customYellow)
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                        }
                        
                        // Date of birth
                        VStack {
                            Button {
                                withAnimation {
                                    showDatePicker.toggle()
                                    showTypeDropdown = false
                                    showConditionDropdown = false
                                    showAgeDropdown = false
                                    showProductivityDropdown = false
                                }
                            } label: {
                                HStack {
                                    Text("Date Of Birth")
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.customYellow)
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showDatePicker {
                                DatePicker("", selection: $animal.birthDate, displayedComponents: .date)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .padding()
                                    .background(Color.black.opacity(0.3))
                                    .colorScheme(.dark)
                                    .accentColor(.customYellow)
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.customYellow, lineWidth: 1)
                                    )
                            }
                        }
                        
                        // Age dropdown
                        VStack {
                            Button {
                                withAnimation {
                                    showAgeDropdown.toggle()
                                    showDatePicker = false
                                    showTypeDropdown = false
                                    showConditionDropdown = false
                                    showProductivityDropdown = false
                                }
                            } label: {
                                HStack {
                                    Text(animal.age.rawValue.isEmpty ? "Age" : animal.age.rawValue)
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.customYellow)
                                        .rotationEffect(.degrees(showAgeDropdown ? 90 : 0))
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showAgeDropdown {
                                VStack(spacing: 0) {
                                    ForEach(AgeType.allCases, id: \.self) { age in
                                        Button {
                                            animal.age = age
                                            withAnimation {
                                                showAgeDropdown = false
                                            }
                                        } label: {
                                            HStack {
                                                Text(age.rawValue)
                                                    .foregroundColor(.customYellow)
                                                Spacer()
                                            }
                                            .padding()
                                            .background(Color.black.opacity(0.3))
                                        }
                                        Divider()
                                            .background(Color.customYellow)
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                        }
                        
                        // Condition dropdown
                        VStack {
                            Button {
                                withAnimation {
                                    showConditionDropdown.toggle()
                                    showDatePicker = false
                                    showTypeDropdown = false
                                    showAgeDropdown = false
                                    showProductivityDropdown = false
                                }
                            } label: {
                                HStack {
                                    Text(animal.condition.rawValue.isEmpty ? "Condition" : animal.condition.rawValue)
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.customYellow)
                                        .rotationEffect(.degrees(showConditionDropdown ? 90 : 0))
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showConditionDropdown {
                                VStack(spacing: 0) {
                                    ForEach(AnimalCondition.allCases, id: \.self) { condition in
                                        Button {
                                            animal.condition = condition
                                            withAnimation {
                                                showConditionDropdown = false
                                            }
                                        } label: {
                                            HStack {
                                                Text(condition.rawValue)
                                                    .foregroundColor(.customYellow)
                                                Spacer()
                                            }
                                            .padding()
                                            .background(Color.black.opacity(0.3))
                                        }
                                        Divider()
                                            .background(Color.customYellow)
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                        }
                        
                        // Productivity dropdown
                        VStack {
                            Button {
                                withAnimation {
                                    showProductivityDropdown.toggle()
                                    showDatePicker = false
                                    showTypeDropdown = false
                                    showConditionDropdown = false
                                    showAgeDropdown = false
                                }
                            } label: {
                                HStack {
                                    Text(animal.productivity.isEmpty ? "Productivity" : animal.productivity)
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.customYellow)
                                        .rotationEffect(.degrees(showProductivityDropdown ? 90 : 0))
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showProductivityDropdown {
                                VStack(spacing: 0) {
                                    ForEach(productivityOptions, id: \.self) { option in
                                        Button {
                                            animal.productivity = option
                                            withAnimation {
                                                showProductivityDropdown = false
                                            }
                                        } label: {
                                            HStack {
                                                Text(option)
                                                    .foregroundColor(.customYellow)
                                                Spacer()
                                            }
                                            .padding()
                                            .background(Color.black.opacity(0.3))
                                        }
                                        Divider()
                                            .background(Color.customYellow)
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                        }
                        
                        // Notes field
                        TextField("Notes", text: $animal.notes)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.customYellow)
                            .accentColor(.customYellow)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.customYellow, lineWidth: 1)
                            )
                            .placeholder(when: animal.notes.isEmpty) {
                                Text("Notes")
                                    .foregroundColor(.customYellow.opacity(0.7))
                                    .padding(.leading, 16)
                            }
                        
                        // Feature field
                        TextField("Feature", text: $animal.feature)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.customYellow)
                            .accentColor(.customYellow)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.customYellow, lineWidth: 1)
                            )
                            .placeholder(when: animal.feature.isEmpty) {
                                Text("Feature")
                                    .foregroundColor(.customYellow.opacity(0.7))
                                    .padding(.leading, 16)
                            }
                    }
                    .padding(.bottom, 80)
                }
                
                Spacer()
            }
            .padding([.horizontal, .bottom])
            
            // Add button at the bottom
            VStack {
                Spacer()
                BaseButton(buttonTitle: "Add") {
                    animalService.addAnimal(animal)
                    dismiss()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

// Extension for placeholder text
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    NewAnimalView()
        .environmentObject(AnimalService())
}
