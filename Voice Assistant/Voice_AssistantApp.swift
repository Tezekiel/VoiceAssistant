import SwiftUI

@main
struct Voice_AssistantApp: App {
    @StateObject private var appData = AppData()
    @State var isLoading = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if !isLoading {
                    NavigationView {
                        MainView(account: $appData.account)
                    }
                } else {
                    ZStack{
                        ProgressView().scaleEffect(x: 3, y: 3, anchor: .center)
                    }
                }
            }.task {
                do {
                    appData.account = try await AppData.load()
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    isLoading = false
                } catch {
                    isLoading = false
                    print(error)
                }
            }
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
