import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var isActive: Bool
    
    init(id: UUID = UUID(), name: String, isActive: Bool = false) {
        self.id = id
        self.name = name
        self.isActive = isActive
    }
    
    mutating func makeActive() -> User {
        self.isActive = true
        return self
    }
}
