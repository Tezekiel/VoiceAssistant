import Foundation

struct Account: Codable {
    var users: [User] = []
    var showAccountPickerOnStart: Bool = true
    var showAccountPicker: Bool = true

    mutating func recalc() -> Account {
        self.showAccountPicker = shouldShow()
        return self
    }
    
    private func shouldShow() -> Bool {
        return showAccountPickerOnStart || !users.contains(where: { $0.isActive })
    }
    
    func getActive() -> User? {
        return self.users.first(where: { $0.isActive })
    }

    func getActiveIndex() -> Int? {
        return self.users.firstIndex(where: { $0.isActive })
    }
    
    mutating func insertRecord(_ record: Record) {
        let userIndex = getActiveIndex() ?? 0
        var newUser = self.users[userIndex]
        newUser.records.insert(record, at: 0)
        self.users[userIndex] = newUser
    }
    
    mutating func makeInactive() {
        self.users = users.map { user in
            User(name: user.name, isActive: false, records: user.records)
        }
    }
}
