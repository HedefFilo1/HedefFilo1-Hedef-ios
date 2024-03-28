//
//  TotalPoints.swift
//  Copilot
//
//  Created by Jamal on 3/28/24.
//

import Foundation

struct TotalPoints: Decodable {
    let totalPoints: Int
}

struct BarPoint: Decodable {
    let id: Int
    let name: String
    let point: Int
}
