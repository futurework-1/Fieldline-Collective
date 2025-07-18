import Foundation

enum MeasurementType {
    case weight
    case volume
    case quantity
    
    // Notification name for unit changes
    static let unitChangedNotification = Notification.Name("measurementUnitChanged")
    
    var value: (String, String) {
        switch self {
        case .weight:
            ("Kg", "T")
        case .volume:
            ("I", "MI")
        case .quantity:
            ("Pcs", "")
        }
    }
    
    var title: ImageResource {
        switch self {
        case .weight:
                .weightTitle
        case .volume:
                .volumeTitle
        case .quantity:
                .quantityTitle
        }
    }
    
    // UserDefaults keys
    static let weightUnitKey = "selectedWeightUnit"
    static let volumeUnitKey = "selectedVolumeUnit"
    
    // Get selected unit index (0 or 1) for the measurement type
    var selectedUnitIndex: Int {
        get {
            switch self {
            case .weight:
                return UserDefaults.standard.integer(forKey: MeasurementType.weightUnitKey)
            case .volume:
                return UserDefaults.standard.integer(forKey: MeasurementType.volumeUnitKey)
            case .quantity:
                return 0 // Quantity always has only one option
            }
        }
        set {
            switch self {
            case .weight:
                UserDefaults.standard.set(newValue, forKey: MeasurementType.weightUnitKey)
            case .volume:
                UserDefaults.standard.set(newValue, forKey: MeasurementType.volumeUnitKey)
            case .quantity:
                break // No need to save for quantity
            }
            
            // Post notification when unit changes
            NotificationCenter.default.post(name: MeasurementType.unitChangedNotification, object: self)
        }
    }
    
    // Get the selected unit string
    var selectedUnit: String {
        let index = selectedUnitIndex
        return index == 0 ? value.0 : value.1
    }
}
