import Foundation
import SwiftUI

class MemberService: ObservableObject {
    @Published var members: [MemberModel] = []
    private let userDefaultsKey = "savedMembers"
    
    init() {
        loadMembers()
    }
    
    func addMember(_ member: MemberModel) {
        members.append(member)
        saveMembers()
    }
    
    func updateMember(_ member: MemberModel) {
        if let index = members.firstIndex(where: { $0.id == member.id }) {
            members[index] = member
            saveMembers()
        }
    }
    
    func deleteMember(at indexSet: IndexSet) {
        members.remove(atOffsets: indexSet)
        saveMembers()
    }
    
    func deleteMember(id: UUID) {
        members.removeAll(where: { $0.id == id })
        saveMembers()
    }
    
    private func saveMembers() {
        if let encodedData = try? JSONEncoder().encode(members) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
    
    private func loadMembers() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let decodedMembers = try? JSONDecoder().decode([MemberModel].self, from: data) else {
            members = []
            return
        }
        
        members = decodedMembers
    }
} 