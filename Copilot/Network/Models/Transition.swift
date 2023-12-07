//
//  .swift
//  Copilot
//
//  Created by Jamal on 12/6/23.
//

import Foundation

struct Transition: Decodable {
    let hgsNo: String
    let entryDate: String?
    let exitDate: String
    let entryPoint: String?
    let exitPoint: String
    let toll: Double
    
    var displayToll: String {
        return "\(toll) TL"
    }
    
    func get(date: String) -> String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = formmater.date(from: date) {
            formmater.dateFormat = "dd.MM.yyyy HH:mm"
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
    
    func getJust(date: String) -> String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = formmater.date(from: date) {
            formmater.dateFormat = "dd.MM.yyyy"
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
    
    func getHour(date: String) -> String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = formmater.date(from: date) {
            formmater.dateFormat = "HH:mm"
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
    
    var exitDisplayDate: String {
        return get(date: exitDate)
    }
    
    var exitJustDisplayDate: String {
        return getJust(date: exitDate)
    }
    
    var exitHourDisplayDate: String {
        return getHour(date: exitDate)
    }
    
    var entryDisplayDate: String {
        return get(date: entryDate ?? "")
    }
    
    var entryJustDisplayDate: String {
        return getJust(date: entryDate ?? "")
    }
    
    var entryHourDisplayDate: String {
        return getHour(date: entryDate ?? "")
    }
}
