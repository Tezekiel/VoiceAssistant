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
                        saveAccountData(account: appData.account.recalc())
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

func saveAccountData(account: Account) {
    Task {
        do {
            print(account)
            try await AppData.save(account: account)
        } catch {
            print(error)
        }
    }
}
