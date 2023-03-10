import SwiftUI

struct ManageRecordsView: View {
    @Binding var records: [Record]
    let save: () -> Void
    
    var body: some View {
        List{
            ForEach($records) { $record in
                NavigationLink(destination: RecordEditView(record: $record).onDisappear{save()}){
                    RecordCardView(record: record)
                }
                .listRowBackground(Color(.white))
            }
        }.listStyle(.automatic)
    }
}

struct ManageRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageRecordsView(records: .constant(Account.sample.records), save: {})
    }
}
