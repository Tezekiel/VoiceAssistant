import SwiftUI

struct RecordView: View {
    @Binding var account: Account
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    @State private var isEditing = false
    @State var record : Record = Record.empty()
    
    fileprivate func saveRecord() {
        account.records.insert(record, at: 0)
        saveAccountData(account)
        isEditing = false
        record = Record.empty()
    }
    
    var body: some View {
        VStack {
            Text("Let's record!")
                .font(.title)
                .padding(.vertical)
            Image(systemName: isRecording ? "mic" :  "mic.slash")
                .font(.largeTitle)
                .padding(.vertical)
            ZStack {
                if isRecording {
                    Button(action: {
                        speechRecognizer.stopTranscribing()
                        isRecording = false
                        withAnimation{
                            record = Record(transcript: speechRecognizer.transcript, alarmAt: getDateFrom(text: speechRecognizer.transcript))
                        }
                    }) {
                        Image(systemName: "stop.circle")
                            .font(.largeTitle)
                            .foregroundColor(.mint)
                    }
                } else {
                    Button(action: {
                        isRecording = true
                        isEditing = false
                        record = Record.empty()
                        speechRecognizer.reset()
                        speechRecognizer.transcribe()
                    }) {
                        Image(systemName: "record.circle")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
            }
            .padding(.vertical)
            if !record.transcript.isEmpty {
                TranscriptCardView(
                    record: record,
                    onSave: { saveRecord() },
                    onEdit: { isEditing = true }
                )
                .padding(.horizontal)
                .transition(.scale)
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isEditing) {
            NavigationView {
                RecordEditView(record: $record)
                    .navigationTitle("Save transcript")
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Discard") {
                                record = Record.empty()
                                isEditing = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save"){
                                saveRecord()
                            }
                        }
                    }
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(account: .constant(Account.sample))
    }
}
