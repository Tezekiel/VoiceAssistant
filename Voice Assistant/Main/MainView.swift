import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            RecordView()
                .tabItem {
                    Label("Record", systemImage: "mic")
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
        MainView()
    }
}
