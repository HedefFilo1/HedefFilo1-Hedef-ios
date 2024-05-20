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
    let createdDate: String?
    let recordType: String?
    let invoiceNumber: String?
    
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
        
        if let recordType {
            return recordType
        }
        
        if let invoiceNumber {
            return invoiceNumber
        }
        return ""
    }
    
    var existDate: String {
        if let appointmentDate {
            return appointmentDate
        }
        if let createdDate {
            return createdDate
        }
        
        return ""
    }
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        formmater.locale = Locale(identifier: "tr_TR")
        if let date = formmater.date(from: existDate) {
            formmater.dateFormat = "dd.MM.yyyy"
            return formmater.string(from: date)
        }
        return ""
    }
}
