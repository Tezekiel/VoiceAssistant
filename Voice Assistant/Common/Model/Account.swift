import Foundation

struct Account: Codable {
    var records: [Record] = []
}

extension Account {
    static let sample = Account(
        records: [Record(transcript: "This is a note from user")]
    )
}
