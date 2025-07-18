import SwiftUI

struct TeamView: View {
    @EnvironmentObject private var memberService: MemberService
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                HeaderElement(title: .farmTeamTitle, withBackButton: false, withImage: false, backButtonAction: nil)
                Image(.adminText)
                    .padding(.bottom)
                Image(.adminBody)
                
                ScrollView {
                    // Tasks table
                    VStack(spacing: 0) {
                        // Table header
                        HStack {
                            Text("")
                                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                                .foregroundColor(.customYellow)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Tasks\nCompleted")
                                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                                .foregroundColor(.customYellow)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("Overdue")
                                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 18))
                                .foregroundColor(.customYellow)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        
                        // Table rows or empty space
                        VStack(spacing: 0) {
                            if !memberService.members.isEmpty {
                                ForEach(Array(memberService.members.enumerated()), id: \.element.id) { index, member in
                                    HStack {
                                        HStack {
                                            Text("\(index + 1)")
                                                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 16))
                                                .foregroundColor(.white)
                                            Text(member.name)
                                                .font(FontFamily.Moderustic.regular.swiftUIFont(size: 16))
                                                .foregroundColor(.customYellow)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .overlay(
                                            Rectangle()
                                                .fill(Color.customYellow)
                                                .frame(height: 1),
                                            alignment: .bottom
                                        )
                                        
                                        Text("\(generateCompletedTasks())")
                                            .font(FontFamily.Moderustic.regular.swiftUIFont(size: 16))
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .overlay(
                                                Rectangle()
                                                    .fill(Color.customYellow)
                                                    .frame(height: 1),
                                                alignment: .bottom
                                            )
                                        
                                        Text("\(generateOverdueTasks())")
                                            .font(FontFamily.Moderustic.regular.swiftUIFont(size: 16))
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .overlay(
                                                Rectangle()
                                                    .fill(Color.customYellow)
                                                    .frame(height: 1),
                                                alignment: .bottom
                                            )
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                }
                            } else {
                                // Empty table content
                                Spacer()
                                    .frame(height: 120)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.customYellow, lineWidth: 2)
                    )
                    .padding(.bottom, 20)
                    
                    // Add new task button
                    NavigationLink {
                        NewTaskView()
                    } label: {
                        Text("Add a new task")
                            .font(FontFamily.Moderustic.medium.swiftUIFont(size: 24))
                            .foregroundColor(.customYellow)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.customBrown)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 8)
                    
                    NavigationLink {
                        AddNewMember()
                    } label: {
                        Text("Add New Team Members")
                            .font(FontFamily.Moderustic.medium.swiftUIFont(size: 24))
                            .foregroundColor(.customBrown)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.customYellow)
                            .cornerRadius(30)
                    }
                }
                .padding(.top)
                .padding(.bottom, 75)
                
            }
            .padding(.horizontal)
        }
    }
    
    private func generateCompletedTasks() -> Int {
        return Int.random(in: 1...10)
    }
    
    private func generateOverdueTasks() -> Int {
        return [0, 1, 2].randomElement() ?? 0
    }
}

#Preview {
    TeamView()
        .environmentObject(MemberService())
}
