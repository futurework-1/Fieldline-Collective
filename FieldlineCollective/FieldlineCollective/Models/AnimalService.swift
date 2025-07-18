import Foundation
import SwiftUI

class AnimalService: ObservableObject {
    @Published var animals: [AnimalModel] = []
    private let userDefaultsKey = "savedAnimals"
    
    init() {
        loadAnimals()
    }
    
    func addAnimal(_ animal: AnimalModel) {
        animals.append(animal)
        saveAnimals()
    }
    
    func updateAnimal(_ animal: AnimalModel) {
        if let index = animals.firstIndex(where: { $0.id == animal.id }) {
            animals[index] = animal
            saveAnimals()
        }
    }
    
    func deleteAnimal(at indexSet: IndexSet) {
        animals.remove(atOffsets: indexSet)
        saveAnimals()
    }
    
    func deleteAnimal(id: UUID) {
        animals.removeAll(where: { $0.id == id })
        saveAnimals()
    }
    
    private func saveAnimals() {
        if let encodedData = try? JSONEncoder().encode(animals) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
    
    private func loadAnimals() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let decodedAnimals = try? JSONDecoder().decode([AnimalModel].self, from: data) else {
            animals = []
            return
        }
        
        animals = decodedAnimals
    }
} 