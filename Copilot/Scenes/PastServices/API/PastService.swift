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

enum PastServiceStatusType: String, Decodable {
    case approved = "APPOINTMENT_APPROVED"
    case workInProgress = "WORK_IN_PROGRESS"
    case new = "NEW"
    case owned = "OWNED"
    case waitingForInformation = "WAITING_FOR_INFORMATION"
    case responseReceived = "RESPONSE_RECEIVED"
    case closed = "CLOSED"
    case none
}

struct PastService: Decodable {
    let id: String?
    let caseNumber: String
    let serviceName: String?
    let appointmentDate: String?
    let recordType: PastServiceRecordType
//    let statusEnum: PastServiceStatusType?
    let appointmentStatusEnum: AppointmentStatus
    
    let address: String?
    let supplierPhone: String?
    let km: Int?
    
    let lon: String?
    let lat: String?
    let accidentTypeId: String?
    
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
            str = App.getString(key: CodeStrings.maintenaceKey) ?? ""
//            return "Bakım"
        case .mechanicalFailure: // Ariza
            str = App.getString(key: CodeStrings.mechanicalFailurKey)
        case .damage:
            str = App.getString(key: CodeStrings.damageKey)
//            str = "Tamir"
        case .tireChange:
//            str = App.getString(key: CodeStrings.tireChangeKey)
//            str = "Lastik Değişim"
            return tireTypeTitle
        case .none:
            return "None"
        }
        return str ?? ""
    }
    
    var tireTypeTitle: String {
        guard let accidentTypeId else {
            return App.getString(key: CodeStrings.tireChangeKey) ?? ""
        }
        let language = Persistence.language ?? CodeStrings.turkish
        let isTurkish = language == CodeStrings.turkish
        switch accidentTypeId {
        case "55":
            return isTurkish ? "Hasar": "Damage"
            
        case "82":
            return isTurkish ? "Yaz Lastiği Değişim": "Summer Tire Change"
            
        case "40":
            return isTurkish ? "Kış Lastiği Değişimi": "Winter Tire Change"
        default:
            return ""
        }
    }
    
    var date: Date? {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            return date
        }
        return nil
    }
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        formmater.locale = Locale(identifier: "tr_TR")
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
