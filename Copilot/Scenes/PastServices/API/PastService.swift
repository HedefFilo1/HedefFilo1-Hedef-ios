//
//  PastService.swift
//  Copilot
//
//  Created by Jamal on 3/31/24.
//

import Foundation

enum PastServiceRecordType: String, Decodable {
    case maintenance = "Maintenance"
    case tireChange = "Tire Change Request"
    case mechanicalFailure = "Mechanical Failure Request"
    case damage = "New Damage Record Request"
    case none = "NONE"
}

struct PastService: Decodable {
    let id: String?
    let caseNumber: String
    let serviceName: String?
    let appointmentDate: String?
    let recordType: PastServiceRecordType
    let statusEnum: CaseStatusType
    let appointmentStatusEnum: AppointmentStatus
    
    let address: String?
    let supplierPhone: String?
    
    let lon: String?
    let lat: String?
    
    var longitude: Double? {
        return Double(lon ?? "")
    }
    
    var latitude: Double? {
        return Double(lat ?? "")
    }
    
    var type: String {
        var str: String?
        switch recordType {
        case .maintenance: // Bakim
            //            str = App.getString(key: CodeStrings.maintenaceKey)
            return "Bakım"
        case .mechanicalFailure: // Ariza
            str = "Ariza" // App.getString(key: CodeStrings.mechanicalFailurKey)
        case .damage:
//            str = App.getString(key: CodeStrings.damageKey)
            str = "Tamir"
        case .tireChange:
//            str = App.getString(key: CodeStrings.tireChangeKey)
            str = "Değişim"
        case .none:
            return "None"
        }
        return str ?? ""
    }
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "d MMMM EEEE"
            return formmater.string(from: date)
        }
        return ""
    }
    
    var time: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "HH:mm"
            return formmater.string(from: date)
        }
        return ""
    }
}
