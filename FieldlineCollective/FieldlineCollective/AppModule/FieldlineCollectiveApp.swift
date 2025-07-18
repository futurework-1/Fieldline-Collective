import SwiftUI

@main
struct FieldlineCollectiveApp: App {
    @StateObject private var animalService = AnimalService()
    @StateObject private var consumableService = ConsumableService()
    @StateObject private var memberService = MemberService()
    @StateObject private var taskService = TaskService()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(animalService)
                .environmentObject(consumableService)
                .environmentObject(memberService)
                .environmentObject(taskService)
        }
    }
}
