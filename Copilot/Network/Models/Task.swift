//
//  Task.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import Foundation
import UIKit

enum TaskStatus: String, Decodable {
    case completed = "COMPLETED"
    case canceled = "CANCELLED"
    case other = "OTHER"
    
    var text: String {
        switch self {
        case .completed:
            return Strings.approved
        case .canceled:
            return Strings.canceled
        case .other:
            return Strings.waitingToApprove
        }
    }
    
    var color: UIColor {
        switch self {
        case .completed:
            return UIColor.textSuccess
        case .canceled:
            return UIColor.theme
        case .other:
            return UIColor.appYellow
        }
    }
}

struct Task: Decodable {
    let id: String?
    //    let subject: String
    let subjectResult: String?
    let additionalInfo: String
    let description: String?
    let statusText: String
    let status: TaskStatus
    let statusTextResult: String?
    let activityDate: String?
    
    var date: Date? {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        if let stringDate = activityDate, let date = formmater.date(from: stringDate) {
            return date
        }
        return nil
    }
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        formmater.locale = Locale(identifier: "tr_TR")
        if let stringDate = activityDate, let date = formmater.date(from: stringDate) {
            formmater.dateFormat = "d MMMM EEEE"
            
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
