import Foundation

class AppData : ObservableObject{
    @Published var account: Account = Account()
            
    private static func fileUrl() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("account.data")
    }
    
    static func load() async throws -> Account {
        try await withCheckedThrowingContinuation{ continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case.success(let account):
                    continuation.resume(returning: account)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<Account, Error>)->Void){
        DispatchQueue.global(qos: .background).async {
            do{
                let fileURL = try fileUrl()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(Account()))
                    }
                    return
                }
                let account = try JSONDecoder().decode(Account.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(account))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(account: Account) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(account: account) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let saved):
                    continuation.resume(returning: saved)
                }
            }
        }
    }
    
    static func save(account: Account, completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do{
                let data = try JSONEncoder().encode(account)
                let outfile = try fileUrl()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(200))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}

extension AppData {
    static let sample = Account(
        users: [
            User(name: "John", isActive: true, records: [Record(transcript: "This is a note from user")]),
            User(name: "Ringo", isActive: false),
            User(name: "Emma", isActive: false)
        ]
    )
}
