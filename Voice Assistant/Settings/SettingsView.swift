import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appData: AppData
    @State private var showPicker = false
    
    var body: some View {
        Form{
            Section(header: Text("App settings")) {
                Button(action: {
                    showPicker = true
                }){
                    Text("Change account")
                }
            }
            
        }.sheet(isPresented: $showPicker) {
            AccountPickerView(account: $appData.account, onUserSelected: {
                print("settings")
                print(appData.account)
                print(appData.account.recalc())
                saveAccountData(appData.account.recalc())
                showPicker = false
            })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
