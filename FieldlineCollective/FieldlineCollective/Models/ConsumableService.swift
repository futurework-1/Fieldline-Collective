import Foundation

class ConsumableService: ObservableObject {
    @Published var consumables: [ConsumableModel] = []
    private let userDefaultsKey = "SavedConsumables"
    
    init() {
        loadData()
    }
    
    private func loadData() {
        // Try to load saved data first
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedConsumables = try? JSONDecoder().decode([ConsumableModel].self, from: data) {
            self.consumables = savedConsumables
        } else {
            // If no saved data, create sample data
            loadSampleData()
            saveData() // Save the initial sample data
        }
    }
    
    private func saveData() {
        if let data = try? JSONEncoder().encode(consumables) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
    
    private func loadSampleData() {
        let today = Date()
        let oneYearFromToday = Calendar.current.date(byAdding: .year, value: 1, to: today) ?? today
        
        consumables = [
            ConsumableModel(
                name: "Crushed wheat",
                type: .food,
                currentQuantity: 15,
                totalQuantity: 50,
                unit: "kg",
                expiryDate: oneYearFromToday,
                lastAction: LastAction(
                    action: "Used",
                    description: "for feeding",
                    date: today
                )
            ),
            
            ConsumableModel(
                name: "Chicken vitamins “HealthyEgg”, 500 g",
                type: .food,
                currentQuantity: 150,
                totalQuantity: 500,
                unit: "g",
                expiryDate: oneYearFromToday,
                lastAction: LastAction(
                    action: "Added",
                    description: "to feed",
                    date: today
                )
            ),
            ConsumableModel(
                name: "Sunflower meal, 30 kg",
                type: .inventory,
                currentQuantity: 5,
                totalQuantity: 30,
                unit: "kg",
                expiryDate: oneYearFromToday,
                lastAction: LastAction(
                    action: "Added",
                    description: "restocked",
                    date: today
                )
            ),
            ConsumableModel(
                name: "Fishmeal protein booster, 10 kg",
                type: .inventory,
                currentQuantity: 2,
                totalQuantity: 10,
                unit: "kg",
                expiryDate: oneYearFromToday,
                lastAction: LastAction(
                    action: "Used",
                    description: "for feeding",
                    date: today
                )
            ),
            ConsumableModel(
                name: "Metal bucket, 10 L",
                type: .consumables,
                currentQuantity: 3,
                totalQuantity: 10,
                unit: "pcs",
                expiryDate: nil,
                lastAction: LastAction(
                    action: "Added",
                    description: "purchased",
                    date: today
                )
            ),
            ConsumableModel(
                name: "Hand sprayer, 5 L",
                type: .consumables,
                currentQuantity: 1,
                totalQuantity: 5,
                unit: "pcs",
                expiryDate: nil,
                lastAction: LastAction(
                    action: "Used",
                    description: "for cleaning",
                    date: today
                )
            ),
            ConsumableModel(
                name: "Sunflower seeds, 2 kg",
                type: .seeds,
                currentQuantity: 500,
                totalQuantity: 2000,
                unit: "g",
                expiryDate: oneYearFromToday,
                lastAction: LastAction(
                    action: "Used",
                    description: "for planting",
                    date: today
                )
            ),
            ConsumableModel(
                name: "Corn seeds, 1 kg",
                type: .seeds,
                currentQuantity: 750,
                totalQuantity: 1000,
                unit: "g",
                expiryDate: oneYearFromToday,
                lastAction: LastAction(
                    action: "Added",
                    description: "purchased",
                    date: today
                )
            )
        ]
    }
    
    func addConsumable(_ consumable: ConsumableModel) {
        consumables.append(consumable)
        saveData()
    }
    
    func updateConsumable(_ consumable: ConsumableModel) {
        if let index = consumables.firstIndex(where: { $0.id == consumable.id }) {
            consumables[index] = consumable
            saveData()
        }
    }
    
    func deleteConsumable(_ consumable: ConsumableModel) {
        consumables.removeAll { $0.id == consumable.id }
        saveData()
    }
    
    func useConsumable(_ consumable: ConsumableModel, quantity: Double, description: String, date: Date = Date()) {
        if let index = consumables.firstIndex(where: { $0.id == consumable.id }) {
            var updatedConsumable = consumables[index]
            updatedConsumable.currentQuantity = max(0, updatedConsumable.currentQuantity - quantity)
            updatedConsumable.lastAction = LastAction(
                action: "Used",
                description: description,
                date: date
            )
            consumables[index] = updatedConsumable
            saveData()
        }
    }
    
    func addToConsumable(_ consumable: ConsumableModel, quantity: Double, description: String, date: Date = Date()) {
        if let index = consumables.firstIndex(where: { $0.id == consumable.id }) {
            var updatedConsumable = consumables[index]
            updatedConsumable.currentQuantity += quantity
            updatedConsumable.lastAction = LastAction(
                action: "Added",
                description: description,
                date: date
            )
            consumables[index] = updatedConsumable
            saveData()
        }
    }
    
    func getConsumables(ofType type: ConsumableType) -> [ConsumableModel] {
        return consumables.filter { $0.type == type }
    }
} 
