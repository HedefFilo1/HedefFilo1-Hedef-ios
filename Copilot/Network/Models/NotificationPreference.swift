//
//  NotificationPreference.swift
//  Copilot
//
//  Created by Jamal on 3/12/24.
//

import Foundation

enum NotificationPreferenceType: String, Decodable {
    case campaign = "CAMPAIGN"
    case weather = "WEATHER"
    case appointmentDate = "APPOINTMENTDATE"
    case contractPeriod = "CONTRACTPERIOD"
}

struct NotificationPreference: Decodable {
    let type: NotificationPreferenceType
    let enabled: Bool
}
