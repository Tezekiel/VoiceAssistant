import SwiftUI

struct RecordCardView: View {
    let record: Record
    
    var body: some View {
        HStack{
            if record.alarmOn {
                Image(systemName: "alarm.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding(.trailing)
            } else {
                Image(systemName: "note.text")
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                    .padding(.trailing)
            }
            VStack(alignment: .leading) {
                Text(record.transcript)
                    .padding(.bottom)
                if record.alarmOn {
                    Text("Alarm: ")
                    Text(record.alarmAt, format: Date.FormatStyle(date: .abbreviated, time: .standard))
                }
            }
            .foregroundColor(.black)
        }
    }
}

struct RecordCardView_Previews: PreviewProvider {
    static var record = Record(
        transcript: "This is a test transcript. User can try to edit it or just save it. Or whatever"
    )
    static var previews: some View {
        RecordCardView(record: record)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
