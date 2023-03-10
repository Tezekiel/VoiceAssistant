import SwiftUI

@main
struct Voice_AssistantApp: App {
    @StateObject private var appData = AppData()
    @State var shown = false
    
    //todo add splash screen while it loads
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView(account: $appData.account)
            }.task {
                do {
                    appData.account = try await AppData.load()
                } catch {
                    print(error)
                }
            }.environmentObject(appData)
        }
    }
}

func saveAccountData(_ account: Account) {
    Task {
        do {
            try await AppData.save(account: account)
        } catch {
            print(error)
        }
    }
}
