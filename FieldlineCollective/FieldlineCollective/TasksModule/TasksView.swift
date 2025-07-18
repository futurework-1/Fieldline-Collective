import SwiftUI

struct TasksView: View {
    @EnvironmentObject private var taskService: TaskService
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title and plus button
                HStack {
                    HeaderElement(title: .tasksTite, withBackButton: false, withImage: false, backButtonAction: nil)
                    
                    NavigationLink(destination: NewTaskView()) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.customYellow)
                    }
                }
                
                // Content section
                if taskService.tasks.isEmpty {
                    Spacer()
                    Text("No tasks added yet")
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(taskService.tasks) { task in
                                TaskRow(task: task)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    .padding(.bottom, 70)
                    .background(Color.customDark)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct TaskRow: View {
    let task: TaskModel
    
    var body: some View {
        NavigationLink(destination: DetailedTaskView(task: task)) {
            Text(task.title)
                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                .foregroundColor(.white)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.black.opacity(0.3))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                )
        }
    }
}

#Preview {
    TasksView()
        .environmentObject(TaskService())
}
