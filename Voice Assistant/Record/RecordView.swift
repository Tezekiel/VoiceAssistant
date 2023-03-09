import SwiftUI

struct RecordView: View {
    @EnvironmentObject var appData: AppData
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    @State private var isEditing = false
    @State var record : Record = Record.empty()
    
    fileprivate func saveRecord() {
        appData.account.insertRecord(record)
        saveAccountData(appData.account)
        isEditing = false
        record = Record.empty()
    }
    
    var body: some View {
        VStack {
            Text("Lets record \(appData.account.getActive()?.name ?? "")")
                .font(.title)
                .padding(.vertical)
            Image(systemName: isRecording ? "mic" :  "mic.slash")
                .font(.largeTitle)
                .padding(.vertical)
            ZStack {
                if isRecording {
                    Button(action: {
                        withAnimation{
                            speechRecognizer.stopTranscribing()
                            record = Record(transcript: speechRecognizer.transcript)
                            isRecording = false
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
                TranscriptCardView(record: record, onSave: { saveRecord() },onEdit: { isEditing = true})
                    .padding(.horizontal)
                    .transition(.scale)
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isEditing) {
            NavigationView {
                Text(record.transcript)
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
        RecordView().environmentObject({ () -> AppData in
            let envObj = AppData()
            envObj.account = AppData.sample
            return envObj
        }())
    }
}
