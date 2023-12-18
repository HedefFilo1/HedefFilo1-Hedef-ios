//
//  GetVehicle.swift
//  Copilot
//
//  Created by Jamal on 11/20/23.
//

import Foundation

struct Vehicle: Decodable {
    let plateNumber: String?
    let make: String
    let model: String
    let leaseDuration: String
    let leaseDistanceLimit: String
    let lastKnownDistance: String
    
    var name: String {
        let brand = make
        let model = model
        return "\(brand) \(model)"
    }
    var lastKM: String {
        let number = lastKnownDistance.formatNumberToThousand()
        return "\(number) \(Strings.ckm)"
    }
    
    var leaseKM: String {
        let number = leaseDistanceLimit.formatNumberToThousand()
        return "\(number) \(Strings.ckm)"
    }
    
    var duration: String {
        let number = leaseDuration ?? "0"
        return "\(number) \(Strings.months)"
    }

}
