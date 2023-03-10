import SwiftUI

struct SettingsView: View {
    @Binding var account: Account
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
            Text("gaifbsakfa")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(account: .constant(Account.sample))
    }
}
