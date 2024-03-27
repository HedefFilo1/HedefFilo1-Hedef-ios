//
//  Notification.swift
//  Copilot
//
//  Created by Jamal on 3/27/24.
//

import Foundation

struct UserNotification: Decodable {
    let id: Int
    let type: String
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
