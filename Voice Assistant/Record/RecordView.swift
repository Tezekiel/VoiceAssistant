import SwiftUI

struct RecordView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        Text("Lets record \(appData.account.getActive()?.name ?? "")")
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
