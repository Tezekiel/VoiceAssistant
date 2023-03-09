import Foundation

struct Record: Identifiable, Codable {
    let id: UUID
    let date: Date
    var transcript: String
    
    init(id: UUID = UUID(), date: Date = Date(), transcript: String = "") {
        self.id = id
        self.date = date
        self.transcript = transcript
    }
    
    static func empty() -> Record {
        return Record(transcript: "")
    }
}
