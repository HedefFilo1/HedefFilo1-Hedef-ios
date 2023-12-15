//
//  MaintenanceLast.swift
//  Copilot
//
//  Created by Jamal on 12/15/23.
//

import Foundation

struct MaintenanceLast: Decodable {
    let serviceName: String
    let date: String
    let part: String
    
    var displayDate: String {
        return date.displayDate(format: "yyyy-MM-dd HH:mm:ss.000000")
    }
}
