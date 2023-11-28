//
//  GetVehicle.swift
//  Copilot
//
//  Created by Jamal on 11/20/23.
//

import Foundation

struct GetVehicle: Decodable {
    let plateNumber: String?
    let make: String
    let model: String
    let leaseDuration: String
    let leaseDistanceLimit: String
    let lastKnownDistance: String
}
