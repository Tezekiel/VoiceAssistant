import SwiftUI

struct ManageRecordsView: View {
    @Binding var records: [Record]
    
    var body: some View {
        ScrollView{
            VStack {
                HStack{
                    Text("Note")
                    RoundedRectangle(cornerRadius: 2.0)
                        .fill(Color(UIColor.darkGray))
                        .frame(width: 40.0, height: 40.0)
                        .padding(.trailing)
                    Text("Alarm")
                    RoundedRectangle(cornerRadius: 2.0)
                        .fill(Color(UIColor.systemOrange))
                        .frame(width: 40.0, height: 40.0)
                }.padding()
                List {
                    ForEach($records) { $record in
                        RecordCardView(
                            record: record,
                            bgColor: record.alarmOn ? Color(UIColor.systemOrange) : Color(UIColor.darkGray),
                            fgColor: record.alarmOn ? Color(UIColor.black) : Color(UIColor.white)
                        )
                    }
                }
                .navigationTitle("Manage records")
            }
        }
    }
}

struct ManageRecordsView_Previews: PreviewProvider {
    static var record = [Record(
        transcript: "This is a test transcript. User can try to edit it or just save it. Or whatever"
    )]
    static var previews: some View {
        ManageRecordsView(records: .constant(record))
    }
}
