//
//  GetTireControl.swift
//  Copilot
//
//  Created by Jamal on 1/23/24.
//

import Foundation

enum TireControlType: String, Decodable {
    case summer = "SUMMER"
    case winter = "WINTER"
}

struct TireControl: Decodable {
    let type: TireControlType
    let available: Bool
}
