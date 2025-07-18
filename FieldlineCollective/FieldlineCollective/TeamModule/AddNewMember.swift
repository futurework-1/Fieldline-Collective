import SwiftUI

struct AddNewMember: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var memberService: MemberService
    
    @State private var member = MemberModel()
    @State private var showRoleDropdown = false
    
    var body: some View {
        ZStack {
            Color.customDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HeaderElement(title: .addMemberTitle, withBackButton: true, withImage: false) {
                    dismiss()
                }
                .frame(height: 100)
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Name field
                        TextField("Name", text: $member.name)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.customYellow)
                            .accentColor(.customYellow)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.customYellow, lineWidth: 1)
                            )
                            .placeholder(when: member.name.isEmpty) {
                                Text("Name")
                                    .foregroundColor(.customYellow.opacity(0.7))
                                    .padding(.leading, 16)
                            }
                        
                        // Phone number field
                        TextField("Phone number", text: $member.phoneNumber)
                            .keyboardType(.phonePad)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.customYellow)
                            .accentColor(.customYellow)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.customYellow, lineWidth: 1)
                            )
                            .placeholder(when: member.phoneNumber.isEmpty) {
                                Text("Phone number")
                                    .foregroundColor(.customYellow.opacity(0.7))
                                    .padding(.leading, 16)
                            }
                        
                        // Email field
                        TextField("Email", text: $member.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.customYellow)
                            .accentColor(.customYellow)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.customYellow, lineWidth: 1)
                            )
                            .placeholder(when: member.email.isEmpty) {
                                Text("Email")
                                    .foregroundColor(.customYellow.opacity(0.7))
                                    .padding(.leading, 16)
                            }
                        
                        // Role dropdown
                        VStack {
                            Button {
                                withAnimation {
                                    showRoleDropdown.toggle()
                                }
                            } label: {
                                HStack {
                                    Text(member.role.rawValue)
                                        .foregroundColor(.customYellow)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.customYellow)
                                        .rotationEffect(.degrees(showRoleDropdown ? 90 : 0))
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                            
                            if showRoleDropdown {
                                VStack(spacing: 0) {
                                    ForEach(MemberRole.allCases, id: \.self) { role in
                                        Button {
                                            member.role = role
                                            withAnimation {
                                                showRoleDropdown = false
                                            }
                                        } label: {
                                            HStack {
                                                Text(role.rawValue)
                                                    .foregroundColor(.customYellow)
                                                Spacer()
                                            }
                                            .padding()
                                            .background(Color.black.opacity(0.3))
                                        }
                                        if role != MemberRole.allCases.last {
                                            Divider()
                                                .background(Color.customYellow)
                                        }
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.customYellow, lineWidth: 1)
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                BaseButton(buttonTitle: "Add") {
                    addMember()
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
    }
    
    private func addMember() {
        guard !member.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        memberService.addMember(member)
        dismiss()
    }
}

#Preview {
    AddNewMember()
        .environmentObject(MemberService())
}
