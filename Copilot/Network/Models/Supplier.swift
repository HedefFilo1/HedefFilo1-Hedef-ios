//
//  Tire.swift
//  Copilot
//
//  Created by Jamal on 11/30/23.
//

import Foundation

enum SupplierType: String {
    case maintenance = "Maintenance"
    case tire = "Tire"
    case damage = "Damage"
    case all
}

struct Supplier: Decodable {
    let id: String
    let name: String
    let address: String?
    let lon: String?
    let lat: String?
    let district: String?
    let city: String?
    let phone: String?
    
    var longitude: Double? {
        return Double(lon ?? "")
    }
    
    var latitude: Double? {
        return Double(lat ?? "")
    }
}
