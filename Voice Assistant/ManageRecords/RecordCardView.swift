import SwiftUI

struct RecordCardView: View {
    let record: Record
    let bgColor: Color
    let fgColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(record.transcript)
                .padding(.bottom)
            HStack{
                Text("Recorded at:")
                Text(record.date, format: Date.FormatStyle(date: .abbreviated, time: .standard))
            }.padding(.bottom)
            if record.alarmOn {
                HStack{
                    Text("Alarm set at: ")
                    Text(record.alarmAt, format: Date.FormatStyle(date: .abbreviated, time: .standard))
                }
            } else {
                Text("No alarms")
            }
        }
        .padding()
        .background(bgColor)
        .foregroundColor(fgColor)
        .cornerRadius(12)
    }
}

struct RecordCardView_Previews: PreviewProvider {
    static var record = Record(
        transcript: "This is a test transcript. User can try to edit it or just save it. Or whatever"
    )
    static var previews: some View {
        RecordCardView(record: record, bgColor: .orange, fgColor: .black)
    }
}
