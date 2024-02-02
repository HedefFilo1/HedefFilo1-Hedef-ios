//
//  GetEligible.swift
//  Copilot
//
//  Created by Jamal on 2/2/24.
//

import Foundation

struct GetEligible: Decodable {
    let eligible: Bool
    let nextMaintenanceKm: Int
}
