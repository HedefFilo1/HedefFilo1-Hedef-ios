//
//  Notification.swift
//  Copilot
//
//  Created by Jamal on 3/27/24.
//

import Foundation
import UIKit

enum UserNotificationType: String, Decodable {
    
    case campaign = "CAMPAIGN"
    case weather = "WEATHER"
    case appointment = "APPOINTMENT"
    case agreement = "AGREEMENT"
    
    var image: UIImage {
        switch self {
            
        case .campaign:
            return Images.percentRedIcon
            
        case .weather:
            return Images.cloudsIcon
            
        case .appointment:
            return Images.servisRandevuIcon
            
        case .agreement:
            return Images.vehicleReturnIcon
        }
    }
}

struct UserNotification: Decodable {
    let id: Int
    let type: UserNotificationType
    let body: String
    var isRead: Bool
    let created: String
    var selected: Bool? = false
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = formmater.date(from: created) {
            return date.relativeDateAsString()
        }
        return ""
    }
}
