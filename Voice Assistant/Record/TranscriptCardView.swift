import SwiftUI

struct TranscriptCardView: View {
    let record: Record
    let onSave: () -> Void
    let onEdit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(record.transcript)
                .font(.headline)
                .padding(.vertical)
                .colorInvert()
            HStack{
                Button("Save") { onSave() }.colorInvert()
                Spacer()
                Button("Edit") { onEdit() }.colorInvert()
            }
            .padding(.vertical)
        }
        .padding()
        .background(Color(UIColor.darkGray))
        .cornerRadius(12)
    }
}

struct TranscriptCardView_Previews: PreviewProvider {
    static var previews: some View {
        TranscriptCardView(
            record: Record(transcript: "This is a test record"), onSave: {}, onEdit: {}
        )
    }
}
