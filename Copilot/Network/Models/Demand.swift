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
    let id: String
    let status: String
    let statusEnum: DemandStatusType
    let webCategoryEnum: String?
    let recordType: String?
}
