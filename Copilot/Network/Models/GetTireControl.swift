//
//  GetTireControl.swift
//  Copilot
//
//  Created by Jamal on 1/23/24.
//

import Foundation

enum TireSupportType: String, Decodable {
    case newSummer = "NEW_SUMMER"
    case newWinter = "NEW_WINTER"
    case change = "CHANGE"
    case damage = "DAMAGE"
    case none
}

enum TireControlType: String, Decodable {
    case summer = "SUMMER"
    case winter = "WINTER"
}

struct TireControl: Decodable {
    let type: TireControlType
    let available: Bool
}
