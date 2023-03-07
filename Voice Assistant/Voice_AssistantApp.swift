import SwiftUI

@main
struct Voice_AssistantApp: App {
    @StateObject private var appData = AppData()
    @State var shown = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if appData.account.showAccountPicker && !shown{
                    AccountPickerView(account: $appData.account) {
                        shown = true
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
            }.environmentObject(appData)
        }
    }
}
