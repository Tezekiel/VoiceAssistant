import SwiftUI

struct AccountPickerView: View {
    @Binding var users: [User]
    @Binding var shouldShowOnStart: Bool
    let onUserSelected: () -> Void
    @State private var newUserName = ""
    
    var body: some View {
        VStack{
            HeaderView()
            Form {
                Section(header: Text("Pick or create user")) {
                    ForEach(users) { user in
                        Button(action: {
                            guard let index = users.firstIndex(where: { $0.id == user.id }) else { return }
                            users[index] = users[index].makeActive()
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
                                users.append(user)
                                newUserName = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(newUserName.isEmpty)
                    }
                }
                Section(header: Text("Quick entry"), footer: Text("Don't worry you can always change this later on.")) {
                    Toggle(isOn: $shouldShowOnStart) {
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
        AccountPickerView(users: .constant(AppData.sample), shouldShowOnStart: .constant(true), onUserSelected: {})
    }
}
