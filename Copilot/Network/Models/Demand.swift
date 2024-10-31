//
//  Demand.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import Foundation
import UIKit

enum DemandStatusType: String, Decodable {
    case solved = "SOLVED"
    case closed = "CLOSED"
    case canceled = "CANCELLED"
    case new = "NEW"
    case workInProgress = "WORK_IN_PROGRESS"
    case waitingForInformation = "WAITING_FOR_INFORMATION"
    case owned = "OWNED"
    case other = "OTHER"
    
    var color: UIColor {
        switch self {
        case .solved, .closed:
            return .textSuccess
            
        case .canceled:
            return .theme
            
        case .new, .workInProgress, .waitingForInformation, .owned, .other:
            return .appYellow
        }
    }
}

struct Demand: Decodable {
    let id: String?
    let status: String
    let statusEnum: DemandStatusType
    let webCategoryEnum: String?
    let recordType: String?
    let statusTextResult: String?
    let supplierName: String?
    let recordTypeResult: String?
    let createdDate: String?
    
    var date: Date? {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        if let stringDate = createdDate, let date = formmater.date(from: stringDate) {
            return date
        }
        return nil
    }
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        formmater.locale = Locale(identifier: "tr_TR")
        if let stringDate = createdDate, let date = formmater.date(from: stringDate) {
            formmater.dateFormat = "yyyy-MM-dd HH:mm"
            
            var identifier = "tr_TR"
            let language = App.language
            if language == CodeStrings.english {
                identifier = "UTC"
            }
            formmater.locale = Locale(identifier: identifier)
            return formmater.string(from: date)
        }
        return ""
    }
}
