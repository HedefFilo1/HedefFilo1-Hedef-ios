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
    let subject: String
    let additionalInfo: String
    let description: String
    let statusText: String
    let status: TaskStatus
}
