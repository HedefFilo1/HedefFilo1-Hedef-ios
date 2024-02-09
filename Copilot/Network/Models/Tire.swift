//
//  Tire.swift
//  Copilot
//
//  Created by Jamal on 11/30/23.
//

import Foundation

struct Tire: Decodable {
    let supplierId: String
    let supplierName: String
    let supplierAddress: String
    let supplierLocation: String?
    let supplierLat: String?
    let supplierLon: String?
    let supplierPhone: String?
    
}
