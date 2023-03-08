import SwiftUI

struct RecordView: View {
    @EnvironmentObject var appData: AppData
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    var body: some View {
        VStack {
            Text("Lets record \(appData.account.getActive()?.name ?? "")")
                .font(.title)
            Image(systemName: isRecording ? "mic" :  "mic.slash")
                .font(.largeTitle)
                .padding(.vertical)
            ZStack {
                if isRecording {
                    Button(action: {
                        speechRecognizer.stopTranscribing()
                        let record = Record(transcript: speechRecognizer.transcript)
                        appData.account.insertRecord(record)
                        saveAccountData(appData.account)
                        isRecording = false
                    }) {
                        Image(systemName: "stop.circle")
                            .font(.title)
                            .foregroundColor(.mint)
                    }
                } else {
                    Button(action: {
                        isRecording = true
                        speechRecognizer.reset()
                        speechRecognizer.transcribe()
                    }) {
                        Image(systemName: "record.circle")
                            .font(.title)
                            .foregroundColor(.red)
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
