import Foundation

struct TaskModel: Identifiable, Codable {
    var id = UUID()
    var title: String
    var date: Date
    var time: Date
    var responsible: String
    var comment: String
    var status: TaskStatus
    
    init(title: String = "",
         date: Date = Date(),
         time: Date = Date(),
         responsible: String = "",
         comment: String = "",
         status: TaskStatus = .pending) {
        self.title = title
        self.date = date
        self.time = time
        self.responsible = responsible
        self.comment = comment
        self.status = status
    }
}

enum TaskStatus: String, Codable, CaseIterable {
    case pending = "pending"
    case done = "done"
    case overdue = "overdue"
} 