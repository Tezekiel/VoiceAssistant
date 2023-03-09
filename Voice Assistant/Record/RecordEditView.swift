import SwiftUI

struct RecordEditView: View {
    @Binding var record: Record
    @State private var addReminder = false
    @State private var alarmAt = Date()
    var body: some View {
        Form{
            Section(header: Text("Created at")){
                Text(record.date, style: .date)
                Text(record.date, style: .time)
            }
            Section(header:Text("Options")){
                Toggle(isOn: $addReminder) {
                    Text("Add a reminder")
                }
                .toggleStyle(.switch)
                // todo hook this up
                if addReminder {
                    DatePicker("Alarm at", selection: $alarmAt)
                }
            }
            Section(header:Text("Edit text")){
                NavigationLink(destination: TextEditor(text: $record.transcript)) {
                    Label(record.transcript, systemImage: "square.and.pencil")
                }
            }
        }
    }
}

struct RecordEditView_Previews: PreviewProvider {
    static var record = Record(
        transcript: "This is a test transcript. User can try to edit it or just save it. Or whatever"
    )
    static var previews: some View {
        RecordEditView(record: .constant(record))
    }
}
