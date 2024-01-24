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
    let caseNumber: String
    let supplierName: String
    let appointmentDate: String
    let recordType: CaseRecordType
    let status: CaseStatusType
    
    let address: String
    let supplierPhone: String
    let appointmentStatus: AppointmentStatus
      
    var title: String {
        var str: String?
        switch recordType {
        case .maintenance:
            //            str = App.getString(key: CodeStrings.maintenaceKey)
            return "Tamir"
        case .mechanicalFailure:
            str = App.getString(key: CodeStrings.mechanicalFailurKey)
        case .damage:
            str = App.getString(key: CodeStrings.damageKey)
        case .tireChange:
            str = App.getString(key: CodeStrings.tireChangeKey)
        case .none:
            return "None"
        }
        return str ?? "unknow"
    }
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        if let date = formmater.date(from: appointmentDate) {
            formmater.dateFormat = "d MMMM EEEE HH:mm"
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
    
    var displayDateWithYear: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        // 2023-12-06T09:00:00.000Z
        if let date = formmater.date(from: appointmentDate) {
            formmater.dateFormat = "d MMMM YYYY EEEE HH:mm"
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
    
    var hourOfDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        // 2023-12-06T09:00:00.000Z
        if let date = formmater.date(from: appointmentDate) {
            formmater.dateFormat = "HH"
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
    
    var minetusOfDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        // 2023-12-06T09:00:00.000Z
        if let date = formmater.date(from: appointmentDate) {
            formmater.dateFormat = "mm"
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
}
