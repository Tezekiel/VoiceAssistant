import Foundation

struct Account: Codable {
    var records: [Record] = []
}

extension Account {
    static let sample = Account(
        records: [
            Record(transcript: "This is a note from user"),
            Record(transcript: "This is another generic note"),
            Record(transcript: "This is a note with an alarm adttached", alarmAt: tomorrowOrToday(), alarmOn: true),
        ]
    )
}
