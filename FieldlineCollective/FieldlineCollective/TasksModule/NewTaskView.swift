import SwiftUI

struct NewTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var taskService: TaskService
    @EnvironmentObject private var memberService: MemberService
    
    @State private var task = TaskModel()
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    @State private var showResponsibleDropdown = false
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HeaderElement(title: nil, stringTitle: "New Task", withBackButton: true, withImage: false) {
                    dismiss()
                }
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Title field
                        TextField("Title", text: $task.title)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.customYellow)
                            .accentColor(.customYellow)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.customYellow, lineWidth: 1)
                            )
                            .placeholder(when: task.title.isEmpty) {
                                Text("Title")
                                    .foregroundColor(.customYellow.opacity(0.7))
                                    .padding(.leading, 16)
                            }
                        
                        // Date picker
                        VStack {
                            Button {
                                withAnimation {
                                    showDatePicker.toggle()
                                    showTimePicker = false
                                    showResponsibleDropdown = false
                                }
                            } label: {
                                HStack {
                                    Text("Date")
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.customYellow)
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showDatePicker {
                                DatePicker("", selection: $task.date, displayedComponents: .date)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .padding()
                                    .background(Color.black.opacity(0.3))
                                    .colorScheme(.dark)
                                    .accentColor(.customYellow)
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.customYellow, lineWidth: 1)
                                    )
                            }
                        }
                        
                        // Time picker
                        VStack {
                            Button {
                                withAnimation {
                                    showTimePicker.toggle()
                                    showDatePicker = false
                                    showResponsibleDropdown = false
                                }
                            } label: {
                                HStack {
                                    Text("Time")
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showTimePicker {
                                DatePicker("", selection: $task.time, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .padding()
                                    .background(Color.black.opacity(0.3))
                                    .colorScheme(.dark)
                                    .accentColor(.customYellow)
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.customYellow, lineWidth: 1)
                                    )
                            }
                        }
                        
                        // Responsible dropdown
                        VStack {
                            Button {
                                withAnimation {
                                    showResponsibleDropdown.toggle()
                                    showDatePicker = false
                                    showTimePicker = false
                                }
                            } label: {
                                HStack {
                                    Text(task.responsible.isEmpty ? "Responsible" : task.responsible)
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.customYellow)
                                        .rotationEffect(.degrees(showResponsibleDropdown ? 90 : 0))
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showResponsibleDropdown {
                                VStack(spacing: 0) {
                                    // Show "me" option if no members exist
                                    if memberService.members.isEmpty {
                                        Button {
                                            task.responsible = "me"
                                            withAnimation {
                                                showResponsibleDropdown = false
                                            }
                                        } label: {
                                            HStack {
                                                Text("me")
                                                    .foregroundColor(.customYellow)
                                                Spacer()
                                            }
                                            .padding()
                                            .background(Color.black.opacity(0.3))
                                        }
                                    } else {
                                        // Show all members
                                        ForEach(memberService.members) { member in
                                            Button {
                                                task.responsible = member.name
                                                withAnimation {
                                                    showResponsibleDropdown = false
                                                }
                                            } label: {
                                                HStack {
                                                    Text(member.name)
                                                        .foregroundColor(.customYellow)
                                                    Spacer()
                                                }
                                                .padding()
                                                .background(Color.black.opacity(0.3))
                                            }
                                            if member.id != memberService.members.last?.id {
                                                Divider()
                                                    .background(Color.customYellow)
                                            }
                                        }
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                        }
                        
                        // Comment field
                        TextField("Comment", text: $task.comment)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.customYellow)
                            .accentColor(.customYellow)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.customYellow, lineWidth: 1)
                            )
                            .placeholder(when: task.comment.isEmpty) {
                                Text("Comment")
                                    .foregroundColor(.customYellow.opacity(0.7))
                                    .padding(.leading, 16)
                            }
                    }
                    .padding(.bottom, 80)
                }
                
                Spacer()
            }
            .padding([.horizontal, .bottom])
            
            // Add button at the bottom
            VStack {
                Spacer()
                BaseButton(buttonTitle: "Add") {
                    addTask()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func addTask() {
        guard !task.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        // Set default responsible if empty
        if task.responsible.isEmpty {
            task.responsible = memberService.members.isEmpty ? "me" : memberService.members.first?.name ?? "me"
        }
        
        taskService.addTask(task)
        dismiss()
    }
}

#Preview {
    NewTaskView()
        .environmentObject(TaskService())
        .environmentObject(MemberService())
}
