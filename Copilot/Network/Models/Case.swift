//
//  Case.swift
//  Copilot
//
//  Created by Jamal on 11/29/23.
//

import Foundation

enum CaseRecordType: String, Decodable {
    case maintenance = "MAINTENANCE"
    case mechanicalFailure = "MECHANICAL_FAILURE"
    case damage = "NEW_DAMAGE"
    case tireChange = "TIRE_CHANGE"
    case none = "NONE"
}

enum CaseStatusType: String, Decodable {
    case approved = "APPOINTMENT_APPROVED"
    case workInProgress = "WORK_IN_PROGRESS"
    case none = "NONE"
    case new = "NEW"
    case owned = "OWNED"
    case waitingForInformation = "WAITING_FOR_INFORMATION"
    case responseReceived = "RESPONSE_RECEIVED"
}

enum AppointmentStatus: String, Decodable {
    case none = "NONE"
    case appointmentRequired = "APPOINTMENT_REQUESTED"
    case appointmentApproved = "APPOINTMENT_APPROVED"
}

struct Case: Decodable {
    let id: String?
    let caseNumber: String
    let supplierName: String?
    let appointmentDate: String?
    let recordType: CaseRecordType
    let status: CaseStatusType
    let appointmentStatus: AppointmentStatus
    
    let address: String?
    let supplierPhone: String?
      
    var title: String {
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
        formmater.timeZone = TimeZone(identifier: "UTC")
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "d MMMM EEEE HH:mm"
//            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
    
    var displayDateWithYear: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        formmater.timeZone = TimeZone(identifier: "UTC")
        // 2023-12-06T09:00:00.000Z
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "d MMMM YYYY EEEE HH:mm"
//            formmater.locale = Locale(identifier: "tr_TR")
            
            return formmater.string(from: date)
        }
        return ""
    }
    
    var hourOfDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        formmater.timeZone = TimeZone(identifier: "UTC")
        // 2023-12-06T09:00:00.000Z
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "HH"
//            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
    
    var minetusOfDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        formmater.timeZone = TimeZone(identifier: "UTC")
        // 2023-12-06T09:00:00.000Z
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "mm"
//            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
}
