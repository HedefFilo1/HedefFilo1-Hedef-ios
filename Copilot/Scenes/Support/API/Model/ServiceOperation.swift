//
//  ServiceOperation.swift
//  Copilot
//
//  Created by Jamal on 4/4/24.
//

import Foundation

enum ServiceOperationType: String, Decodable {
    case maintenance = "Maintenance"
    case tireChange = "Tire Change Request"
    case mechanicalFailure = "Mechanical Failure Request"
    case damage = "New Damage Record Request"
    case none = "NONE"
}

struct ServiceOperation: Decodable {
    let id: String?
    let supplierName: String?
    let serviceName: String?
    let appointmentDate: String?
    let recordType: String?
//    let recordType_: ServiceOperationType?
    
    var dispayTitle: String {
        if let supplierName {
            return supplierName
        }
        
        if let serviceName {
            return serviceName
        }
        return ""
    }
    
    var type: String {
        var str: String?
        
        if let recordType, let type = ServiceOperationType(rawValue: recordType) {
            switch type {
            case .maintenance: // Bakim
                str = App.getString(key: CodeStrings.maintenaceKey)
                //            return "Bakım"
            case .mechanicalFailure: // Ariza
                str = App.getString(key: CodeStrings.mechanicalFailurKey)
            case .damage:
                str = App.getString(key: CodeStrings.damageKey)
                //            str = "Tamir"
            case .tireChange:
                str = App.getString(key: CodeStrings.tireChangeKey)
                //            str = "Değişim"
            case .none:
                return "None"
            }
        }
        return str ?? ""
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
