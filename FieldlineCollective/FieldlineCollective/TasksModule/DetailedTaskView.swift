import SwiftUI

struct DetailedTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var taskService: TaskService
    @State private var task: TaskModel
    
    init(task: TaskModel) {
        self._task = State(initialValue: task)
    }
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HeaderElement(title: nil, stringTitle: task.title, withBackButton: true, withImage: false) {
                    dismiss()
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Due section
                        detailSection(title: "Due", value: "\(task.date.formatted(date: .abbreviated, time: .omitted)), by \(task.time.formatted(date: .omitted, time: .shortened))")
                        
                        // Responsible section
                        detailSection(title: "Responsible", value: task.responsible)
                        
                        // Comment section
                        detailSection(title: "Comment", value: task.comment.isEmpty ? "—" : task.comment)
                        
                        // Status buttons
                        HStack(spacing: 16) {
                            Button {
                                updateTaskStatus(.done)
                            } label: {
                                Text("Done")
                                    .font(FontFamily.Moderustic.medium.swiftUIFont(size: 24))
                                    .foregroundColor(task.status == .done ? .white : .customYellow)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(task.status == .done ? .customYellow : .white)
                                    .cornerRadius(30)
                            }
                            
                            Button {
                                updateTaskStatus(.overdue)
                            } label: {
                                Text("Overdue")
                                    .font(FontFamily.Moderustic.medium.swiftUIFont(size: 24))
                                    .foregroundColor(task.status == .overdue ? .white : .customYellow)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(task.status == .overdue ? .customYellow : .white)
                                    .cornerRadius(30)
                            }
                        }
                        .padding(.top, 20)
                        
                        // Image
                        Image(.eggsImg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
    }
    
    private func detailSection(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                .foregroundColor(.customYellow)
                .underline()
            
            Text(value)
                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 16))
                .foregroundColor(.white)
        }
    }
    
    private func updateTaskStatus(_ newStatus: TaskStatus) {
        task.status = newStatus
        taskService.updateTask(task)
    }
}

#Preview {
    NavigationView {
        DetailedTaskView(task: TaskModel(
            title: "Add mineral supplements to cow feed",
            date: Date(),
            time: Date(),
            responsible: "Mikhail",
            comment: "Mix in calcium and salt blocks. Mark dosage for each animal.",
            status: .pending
        ))
        .environmentObject(TaskService())
    }
} 
