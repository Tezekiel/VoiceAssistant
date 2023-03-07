import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack{
            Image(systemName: "waveform.and.mic")
                .font(.largeTitle)
                .padding(.top)
            Text("Voice Assistant")
                .font(.title)
                .padding(.vertical)
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
