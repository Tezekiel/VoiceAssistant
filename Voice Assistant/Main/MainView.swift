import SwiftUI

struct MainView: View {
    @Binding var account: Account
    
    var body: some View {
        TabView{
            RecordView(account: $account)
            .tabItem { Label("Record", systemImage: "mic") }
            ManageRecordsView(records: $account.records) {
                saveAccountData(account)
            }
            .tabItem { Label("Manage records", systemImage: "list.bullet.circle") }
            SettingsView(account: $account)
            .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(account: .constant(Account.sample))
    }
}
