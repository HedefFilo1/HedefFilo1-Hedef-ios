//
//  String+Capitalize.swift
//  PayCore
//
//  Created by Fikri Can Cankurtaran on 21.07.2022.
//

import Foundation
import UIKit

extension String {
    
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
    
    var isLetterString: Bool {
        return self.range(of: "^[a-zA-z]*$", options: .regularExpression) != nil
    }
    
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    mutating func applyPattern(pattern: String, replacementCharacter: Character) -> String {
        for index in 0 ..< pattern.count {
            guard index < self.count else { return self }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            self.insert(patternCharacter, at: stringIndex)
        }
        return self
    }
    
    func getServerDate() -> String {
        let formmater = DateFormatter()
        formmater.dateFormat = "dd.MM.yyyy"
        formmater.timeZone = TimeZone(identifier: "GMT")
        
        let date = formmater.date(from: self) ?? Date()
        
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let string = iso8601DateFormatter.string(from: date)
        return string
    }
    
    func displayDate(format: String = "yyyy-MM-dd'T'HH:mm:ss", convertFormat: String = "dd.MM.yyyy") -> String {
        let formmater = DateFormatter()
        formmater.dateFormat = format
        // 2023-12-06T09:00:00.000Z
        if let date = formmater.date(from: self) {
            formmater.dateFormat = convertFormat
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
        
    }
    
    var pureText: String {
        let text = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return text.components(separatedBy: .whitespaces).joined()
    }
    
    func formatNumberToThousand() -> String {
        let int = Int(self) ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        let formattedNumber = numberFormatter.string(from: NSNumber(value: int))
        return formattedNumber ?? ""
    }
    
    func getFormattedIntNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let int = Int(self) ?? -1
        let nsNumber = NSNumber(value: int)
        let str = formatter.string(from: nsNumber) ?? ""
        return str
    }
    
}

extension Date {
    func getServerDate() -> String {
        let formmater = DateFormatter()
        //        formmater.dateFormat = "YYYY-MM-ddTHH:MM:00.000Z"
        formmater.timeZone = TimeZone(identifier: "UTC")
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let result = formmater.string(from: self) + ":00.000Z"
        return result
    }
    
    public func setTime(hour: Int, min: Int) -> Date? {
        let compos: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(compos, from: self)
        components.hour = hour
        components.minute = min
        return cal.date(from: components)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func relativeDateAsString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: "tr_TR")
        let string = formatter.localizedString(for: self, relativeTo: Date())
        return string
    }
    
}

extension Data {
    var prettyPrintedJSONString: String { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return "could not read json string" }
        
        return prettyPrintedString as String
        
    }
}
