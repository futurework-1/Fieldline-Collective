import SwiftUI

struct MainView: View {
    @State private var tabSelected: Tab = .tab1
    @EnvironmentObject private var animalService: AnimalService
    @EnvironmentObject private var consumableService: ConsumableService
    @EnvironmentObject private var memberService: MemberService
    @EnvironmentObject private var taskService: TaskService
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TabView(selection: $tabSelected) {
                        LivestockView()
                            .environmentObject(animalService)
                            .tag(Tab.tab1)
                        
                        TasksView()
                            .environmentObject(taskService)
                            .tag(Tab.tab2)
                        
                        AccountingView()
                            .environmentObject(consumableService)
                            .tag(Tab.tab3)
                        
                        TeamView()
                            .environmentObject(memberService)
                            .tag(Tab.tab4)
                        
                        SettingsView()
                            .tag(Tab.tab5)
                    }
                }
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $tabSelected)
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AnimalService())
        .environmentObject(ConsumableService())
        .environmentObject(MemberService())
        .environmentObject(TaskService())
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Image(selectedTab == tab ? "\(tab.rawValue)s" : tab.rawValue)
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    
                }
            }
            .frame(height: 58)
            .padding(.horizontal, 10)
            .background(.white.opacity(0.8))
            .cornerRadius(40)
            .padding()
        }
    }
}

enum Tab: String, CaseIterable {
    case tab1
    case tab2
    case tab3
    case tab4
    case tab5
}
