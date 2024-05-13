//
//  ProccessRequest.swift
//  Copilot
//
//  Created by Jamal on 4/5/24.
//

import Foundation

struct ProccessRequest: Decodable {
    let id: String?
    let supplierName: String?
    let contactName: String?
    let plateNumber: String?
    let appointmentDate: String?
    
    var displayTitle: String {
        if let supplierName {
            return supplierName
        }
        
        if let contactName {
            return contactName
        }
        
        if let plateNumber {
            return plateNumber
        }
        return ""
    }
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        formmater.locale = Locale(identifier: "tr_TR")
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "dd.MM.yyyy"
            return formmater.string(from: date)
        }
        return ""
    }
}
