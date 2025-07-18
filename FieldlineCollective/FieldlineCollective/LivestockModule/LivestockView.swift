import SwiftUI

struct LivestockView: View {
    @EnvironmentObject private var animalService: AnimalService
    @State private var selectedAnimalType: AnimalType? = nil
    @State private var selectedCondition: AnimalCondition? = nil
    @State private var selectedAge: AgeType? = nil
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                HeaderElement(title: .livestockTtitle, withBackButton: false, withImage: false, backButtonAction: nil)
                
                // Filters section
                HStack(spacing: 10) {
                    // Animal Type Filter
                    Menu {
                        Button("All") {
                            selectedAnimalType = nil
                        }
                        ForEach(AnimalType.allCases, id: \.self) { type in
                            Button(type.rawValue) {
                                selectedAnimalType = type
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedAnimalType?.rawValue ?? "All")
                            Image(systemName: "chevron.down")
                                .foregroundColor(.customBlue)
                                .font(.caption)
                        }
                        .foregroundColor(.customBlue)
                        .padding(8)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    }
                    
                    // Condition Filter
                    Menu {
                        Button("All") {
                            selectedCondition = nil
                        }
                        ForEach(AnimalCondition.allCases, id: \.self) { condition in
                            Button(condition.rawValue) {
                                selectedCondition = condition
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedCondition?.rawValue ?? "All")
                            Image(systemName: "chevron.down")
                                .foregroundColor(.customBlue)
                                .font(.caption)
                        }
                        .foregroundColor(.customBlue)
                        .padding(8)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    }
                    
                    // Age Filter
                    Menu {
                        Button("All") {
                            selectedAge = nil
                        }
                        ForEach(AgeType.allCases, id: \.self) { age in
                            Button(age.rawValue) {
                                selectedAge = age
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedAge?.rawValue ?? "All")
                            Image(systemName: "chevron.down")
                                .foregroundColor(.customBlue)
                                .font(.caption)
                        }
                        .foregroundColor(.customBlue)
                        .padding(8)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    }
                    
                    Spacer()
                    
                    // Plus button
                    NavigationLink(destination: NewAnimalView()) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.customYellow)
                    }
                }
                .padding()
                
                // Content section
                if filteredAnimals.isEmpty {
                    Spacer()
                    Text("No animals added yet")
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(filteredAnimals) { animal in
                                AnimalRow(animal: animal)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    .padding(.bottom, 70)
                    .background(Color.customDark)
                }
                if filteredAnimals.count < 3 {
                    VStack {
                        Spacer()
                        Image(.eggsImg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding(.bottom, 70)
                    }
                }
                Spacer()
            }
        }
    }
    
    private var filteredAnimals: [AnimalModel] {
        var animals = animalService.animals
        
        if let type = selectedAnimalType {
            animals = animals.filter { $0.type == type }
        }
        
        if let condition = selectedCondition {
            animals = animals.filter { $0.condition == condition }
        }
        
        if let age = selectedAge {
            animals = animals.filter { $0.age == age }
        }
        
        return animals
    }
}

struct AnimalRow: View {
    let animal: AnimalModel
    
    var body: some View {
        NavigationLink(destination: DetailedAnimalView(animal: animal)) {
            Text(animal.name)
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
    }
}

#Preview {
    NavigationView {
        LivestockView()
            .environmentObject(AnimalService())
    }
}
