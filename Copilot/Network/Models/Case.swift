//
//  Case.swift
//  Copilot
//
//  Created by Jamal on 11/29/23.
//

import Foundation

enum CaseRecordType: String {
    case maintenance
    case mechanicalFailure
    case damage
    case tireChange
}

enum CaseStatusType: String, Decodable {
    case approved = "APPOINTMENT_APPROVED"
}

struct Case: Decodable {
    let caseNumber: String
    let supplierName: String
    let appointmentDate: String
    let recordType: String
    let status: CaseStatusType
    
    let address: String
    let supplierPhone: String
    
    var caseRecordType: CaseRecordType {
        let record = recordType.lowercased()
        if record.contains(CaseRecordType.maintenance.rawValue) {
            return .maintenance
        }
        if record.contains(CaseRecordType.mechanicalFailure.rawValue) {
            return .mechanicalFailure
        }
        if record.contains(CaseRecordType.damage.rawValue.lowercased()) {
            return .damage
        }
        if record.contains(CaseRecordType.tireChange.rawValue) {
            return .maintenance
        }
        return .maintenance
    }
    
    var title: String {
        var str: String?
        switch caseRecordType {
        case .maintenance:
//            str = App.getString(key: CodeStrings.maintenaceKey)
            return "Tamir"
        case .mechanicalFailure:
            str = App.getString(key: CodeStrings.mechanicalFailurKey)
        case .damage:
            str = App.getString(key: CodeStrings.damageKey)
        case .tireChange:
            str = App.getString(key: CodeStrings.tireChangeKey)
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
