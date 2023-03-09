import Foundation

struct Record: Identifiable, Codable {
    let id: UUID
    let date: Date
    var transcript: String
    var alarmAt: Date
    var alarmOn: Bool
        
    init(id: UUID = UUID(), date: Date = Date(), transcript: String = "", alarmAt: Date = tomorrowOrToday(), alarmOn: Bool = false) {
        self.id = id
        self.date = date
        self.transcript = transcript
        self.alarmAt = alarmAt
        self.alarmOn = alarmOn
    }
    
    static func empty() -> Record {
        return Record(transcript: "")
    }
}
