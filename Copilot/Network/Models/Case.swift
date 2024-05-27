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
    
    let lon: String?
    let lat: String?
    
    var longitude: Double? {
        return Double(lon ?? "")
    }
    
    var latitude: Double? {
        return Double(lat ?? "")
    }
      
    var title: String {
        
        switch recordType {
        case .maintenance: // Bakim
            return App.getString(key: CodeStrings.maintenaceKey) ?? "Bakım"
            
        case .mechanicalFailure: // Arıza
             return App.getString(key: CodeStrings.mechanicalFailurKey) ?? "Arıza"
        case .damage:
            return App.getString(key: CodeStrings.damageKey) ?? "Tamir"
        case .tireChange:
            return App.getString(key: CodeStrings.tireChangeKey) ?? "Değişim"
        case .none:
            return "None"
        }
    }
    
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
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
    
    var displayDateWithYear: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
//        formmater.timeZone = TimeZone(identifier: "UTC")
        formmater.locale = Locale(identifier: "tr_TR")
        // 2023-12-06T09:00:00.000Z
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "d MMMM YYYY EEEE HH:mm"
//            formmater.timeZone = TimeZone(identifier: "UTC")
//            formmater.locale = Locale(identifier: "tr_TR")
            
            return formmater.string(from: date)
        }
        return ""
    }
    
    var hourOfDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
//        formmater.timeZone = TimeZone(identifier: "UTC")
//        formmater.locale = Locale(identifier: "tr_TR")
        // 2023-12-06T09:00:00.000Z
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "HH"
            return formmater.string(from: date)
        }
        return ""
    }
    
    var minetusOfDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
//        formmater.timeZone = TimeZone(identifier: "UTC")
//        formmater.locale = Locale(identifier: "tr_TR")
        // 2023-12-06T09:00:00.000Z
        if let appointement = appointmentDate, let date = formmater.date(from: appointement) {
            formmater.dateFormat = "mm"
            return formmater.string(from: date)
        }
        return ""
    }
}
