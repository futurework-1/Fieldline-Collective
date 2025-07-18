import Foundation

struct MemberModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var phoneNumber: String
    var email: String
    var role: MemberRole
    
    init(name: String = "",
         phoneNumber: String = "",
         email: String = "",
         role: MemberRole = .member) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.role = role
    }
}

enum MemberRole: String, Codable, CaseIterable {
    case admin = "Admin"
    case member = "Member"
    case observer = "Observer"
} 