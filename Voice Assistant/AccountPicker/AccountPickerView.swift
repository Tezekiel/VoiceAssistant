import SwiftUI

struct AccountPickerView: View {
    @Binding var account: Account
    let onUserSelected: () -> Void
    @State private var newUserName = ""
    
    var body: some View {
        VStack{
            HeaderView()
            Form {
                Section(header: Text("Pick or create user")) {
                    ForEach(account.users) { user in
                        Button(action: {
                            guard let index = account.users.firstIndex(where: { $0.id == user.id }) else { return }
                            account.users = account.users.map({User(name: $0.name)})
                            account.users[index].makeActive()
                            onUserSelected()
                        }){
                            Text(user.name)
                        }
                    }
                    HStack {
                        TextField("Create new user", text: $newUserName)
                        Button(action: {
                            withAnimation{
                                let user = User(name: newUserName)
                                account.users.append(user)
                                newUserName = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(newUserName.isEmpty)
                    }
                }
                Section(header: Text("Quick entry"), footer: Text("Don't worry, you can always change this later on.")) {
                    Toggle(isOn: $account.showAccountPickerOnStart) {
                        Text("Show this screen on app start")
                    }
                    .toggleStyle(.switch)
                }
            }
        }
    }
}

struct AccountPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AccountPickerView(account: .constant(AppData.sample), onUserSelected: {})
    }
}
