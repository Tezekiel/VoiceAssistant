import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var isActive: Bool
    var records: [Record] = []
    
    init(id: UUID = UUID(), name: String, isActive: Bool = false, records: [Record] = []) {
        self.id = id
        self.name = name
        self.isActive = isActive
        self.records = records
    }
    
    mutating func makeActive() {
        self.isActive = true
    }
}
