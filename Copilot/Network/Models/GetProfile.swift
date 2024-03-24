//
//  GetProfile.swift
//  Copilot
//
//  Created by Jamal on 11/20/23.
//

import Foundation

struct GetProfile: Decodable {
    let name: String?
    let surname: String?
    let phoneNumber: String
    let email: String
    let plateNumber: String
    let licenseNumber: String
    let taxId: String?
    
    var nameSurname: String {
        var text = name ?? ""
        if let surname {
            text += " \(surname)"
        }
        return text
    }
}
