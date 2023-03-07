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
}
