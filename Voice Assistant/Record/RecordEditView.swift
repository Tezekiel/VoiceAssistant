import SwiftUI

struct RecordEditView: View {
    @Binding var record: Record
    @State private var hasPermission = false
    
    var body: some View {
        Form {
            Section(header: Text("Created at")){
                Text(record.date, format: Date.FormatStyle(date: .abbreviated, time: .standard))
            }
            Section(header:Text("Reminder")){
                Toggle(isOn: $record.alarmOn) {
                    Text("Activate alarm")
                }
                .disabled(!hasPermission)
                .onTapGesture(perform: {
                    if record.alarmOn {
                        scheduleLocal(record: record)
                    }
                })
                .toggleStyle(.switch)
                DatePicker("Alarm at", selection: $record.alarmAt)
            }
            Section(header:Text("Edit text")){
                NavigationLink(destination: TextEditor(text: $record.transcript).padding()) {
                    Label(record.transcript, systemImage: "square.and.pencil")
                }
            }
        }
        .navigationTitle("Manage records")
        .onAppear {
            registerLocal() {
                hasPermission = true
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

func registerLocal(_ onGranted: @escaping () -> Void) {
    let center = UNUserNotificationCenter.current()

    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if granted {
            onGranted()
        } else {
            print("No permission for local notifications")
        }
    }
}

func scheduleLocal(record: Record) {
    let center = UNUserNotificationCenter.current()

    let content = UNMutableNotificationContent()
    content.title = "Voice assistant alarm"
    content.body = record.transcript
    content.categoryIdentifier = "alarm"
    content.sound = UNNotificationSound.default

    let dateComp = Calendar.current.dateComponents([.year, .month, .day], from: record.alarmAt)
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
}
