import Foundation
import SwiftUI

class TaskService: ObservableObject {
    @Published var tasks: [TaskModel] = []
    private let userDefaultsKey = "savedTasks"
    
    init() {
        loadTasks()
    }
    
    func addTask(_ task: TaskModel) {
        tasks.append(task)
        saveTasks()
    }
    
    func updateTask(_ task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks()
        }
    }
    
    func deleteTask(at indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
        saveTasks()
    }
    
    func deleteTask(id: UUID) {
        tasks.removeAll(where: { $0.id == id })
        saveTasks()
    }
    
    private func saveTasks() {
        if let encodedData = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
    
    private func loadTasks() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let decodedTasks = try? JSONDecoder().decode([TaskModel].self, from: data) else {
            tasks = []
            return
        }
        
        tasks = decodedTasks
    }
} 