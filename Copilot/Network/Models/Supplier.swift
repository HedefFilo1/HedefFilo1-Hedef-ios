//
//  Tire.swift
//  Copilot
//
//  Created by Jamal on 11/30/23.
//

import Foundation

struct Supplier: Decodable {
    let id: String
    let name: String
    let address: String?
    let lon: String?
    let lat: String?
    
    var longitude: Double? {
        return Double(lon ?? "")
    }
    
    var latitude: Double? {
        return Double(lat ?? "")
    }
}
