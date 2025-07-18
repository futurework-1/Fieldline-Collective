import SwiftUI

struct ConsumableModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: ConsumableType
    var currentQuantity: Double
    var totalQuantity: Double
    var unit: String
    var expiryDate: Date?
    var lastAction: LastAction?
    
    init(name: String = "",
         type: ConsumableType = .food,
         currentQuantity: Double = 0,
         totalQuantity: Double = 0,
         unit: String = "kg",
         expiryDate: Date? = nil,
         lastAction: LastAction? = nil) {
        self.name = name
        self.type = type
        self.currentQuantity = currentQuantity
        self.totalQuantity = totalQuantity
        self.unit = unit
        self.expiryDate = expiryDate
        self.lastAction = lastAction
    }
    
    var remainingText: String {
        return "\(Int(currentQuantity)) \(unit)"
    }
    
    var totalText: String {
        return "\(Int(totalQuantity)) \(unit)"
    }
}

enum ConsumableType: String, Codable, CaseIterable {
    case food = "Food"
    case seeds = "Seeds"
    case consumables = "Consumables"
    case inventory = "Inventory"
}

struct LastAction: Codable {
    let action: String // "Used" or "Added"
    let description: String // "morning feeding" or "purchased from store"
    let date: Date
    
    var displayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return "\(action) — \(description), \(formatter.string(from: date))"
    }
} 
