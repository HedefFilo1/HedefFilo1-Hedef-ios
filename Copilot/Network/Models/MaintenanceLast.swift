//
//  MaintenanceLast.swift
//  Copilot
//
//  Created by Jamal on 12/15/23.
//

import Foundation

//struct MaintenanceLast: Decodable {
//    let serviceName: String
//    let date: String
//    let part: String
//    
//    var displayDate: String {
//        return date.displayDate(format: "yyyy-MM-dd HH:mm:ss.000000")
//    }
//}

struct MaintenanceLast: Decodable {
    let serviceName: String
    let address: String
    let appointmentDate: String?
    
    var date: Date? {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
//        formmater.timeZone = TimeZone(identifier: "UTC")
        formmater.locale = Locale(identifier: "tr_TR")
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            return date
        }
        return nil
    }
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
//        formmater.timeZone = TimeZone(identifier: "UTC")
        formmater.locale = Locale(identifier: "tr_TR")
        
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "d MMMM EEEE HH:mm"
            var identifier = "tr_TR"
            let language = Persistence.language ?? CodeStrings.turkish
            if language == CodeStrings.english {
                identifier = "UTC"
            }
            formmater.locale = Locale(identifier: identifier)
            return formmater.string(from: date)
        }
        return ""
    }
}
