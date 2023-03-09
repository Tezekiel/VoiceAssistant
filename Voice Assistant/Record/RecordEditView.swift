import SwiftUI

struct RecordEditView: View {
    @Binding var record: Record
    
    var body: some View {
        Form {
            Section(header: Text("Created at")){
                Text(record.date, format: Date.FormatStyle(date: .abbreviated, time: .standard))
            }
            Section(header:Text("Reminder")){
                Toggle(isOn: $record.alarmOn) {
                    Text("Activate alarm")
                }
                .toggleStyle(.switch)
                // todo hook this up
                DatePicker("Alarm at", selection: $record.alarmAt)
            }
            Section(header:Text("Edit text")){
                NavigationLink(destination: TextEditor(text: $record.transcript).padding()) {
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
