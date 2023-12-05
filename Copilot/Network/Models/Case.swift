//
//  Case.swift
//  Copilot
//
//  Created by Jamal on 11/29/23.
//

import Foundation
struct Case: Decodable {
    let caseNumber: String
    let supplierName: String
    let appointmentDate: String
    let recordType: String
    let status: String
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        // 2023-12-06T09:00:00.000Z
        if let date = formmater.date(from: appointmentDate) {
            formmater.dateFormat = "d MMMM EEEE HH:mm"
            formmater.locale = Locale(identifier: "tr_TR")
            return formmater.string(from: date)
        }
        return ""
    }
}
