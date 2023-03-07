import SwiftUI

@main
struct Voice_AssistantApp: App {
    @StateObject private var appData = AppData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if appData.account.showAccountPicker {
                    AccountPickerView(users: $appData.account.users, shouldShowOnStart: $appData.account.showAccountPickerOnStart) {
                        Task {
                            do {
                                try await AppData.save(account: appData.account.recalc())
                            } catch {
                                print(error)
                            }
                        }
                    }
                } else {
                    MainView()
                }
            }.task {
                do {
                    appData.account = try await AppData.load()
                } catch {
                    print(error)
                }
            }
        }
    }
}
