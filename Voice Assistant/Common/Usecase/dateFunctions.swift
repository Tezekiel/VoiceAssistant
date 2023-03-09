import Foundation

func getDateFrom(text: String, alternative: Date = tomorrowOrToday()) -> Date {
    let types: NSTextCheckingResult.CheckingType = [.date ]
    let detector = try? NSDataDetector(types: types.rawValue)
    var date: Date? = nil
    
    let result = detector?.firstMatch(in: text, range: NSMakeRange(0, text.utf16.count))
    if result?.resultType == .date {
        date = (result?.date)!
    }
    return date ?? alternative
}

func tomorrowOrToday() -> Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
}
