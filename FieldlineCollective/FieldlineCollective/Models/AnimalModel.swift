import Foundation

struct AnimalModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: AnimalType
    var birthDate: Date
    var condition: AnimalCondition
    var age: AgeType
    var productivity: String
    var notes: String
    var feature: String
    
    init(name: String = "", 
         type: AnimalType = .pig,
         birthDate: Date = Date(),
         condition: AnimalCondition = .healthy,
         age: AgeType = .young,
         productivity: String = "",
         notes: String = "",
         feature: String = "") {
        self.name = name
        self.type = type
        self.birthDate = birthDate
        self.condition = condition
        self.age = age
        self.productivity = productivity
        self.notes = notes
        self.feature = feature
    }
}

enum AnimalType: String, Codable, CaseIterable {
    case pig = "Pig"
    case chicken = "Chicken"
    case cow = "Cow"
    case goat = "Goat"
    case duck = "Duck"
    case sheep = "Sheep"
}

enum AnimalCondition: String, Codable, CaseIterable {
    case healthy = "Healthy"
    case sick = "Sick"
    case underSurveillance = "Under surveillance"
}

enum AgeType: String, Codable, CaseIterable {
    case newborn = "Newborn"
    case young = "Young"
    case elderly = "Elderly"
}
