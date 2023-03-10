import SwiftUI

struct MainView: View {
    @EnvironmentObject var appData: AppData
    // todo getACtive user fucks everything up...need to model it differently
    
    var body: some View {
        TabView{
            RecordView()
                .tabItem {
                    Label("Record", systemImage: "mic")
                }
            ManageRecordsView(records: $appData.account.users)
                .tabItem {
                    Label("Manage records", systemImage: "list.bullet.circle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject({ () -> AppData in
            let envObj = AppData()
            envObj.account = AppData.sample
            return envObj
        }())
    }
}
