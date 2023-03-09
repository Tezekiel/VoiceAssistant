import SwiftUI

struct ManageRecordsView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        List {
            ForEach(appData.account.getActive()?.records ?? []) { record in
                Text(record.transcript)
            }
        }
    }
}

struct ManageRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageRecordsView().environmentObject({ () -> AppData in
            let envObj = AppData()
            envObj.account = AppData.sample
            return envObj
        }())
    }
}
