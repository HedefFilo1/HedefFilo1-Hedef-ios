//
//  ContentString.swift
//  Copilot
//
//  Created by Jamal on 12/13/23.
//

import Foundation

struct ContentString: Decodable {
    let id: Int
    let lang: String
    let strKey: String
    let strValue: String?
    let clientContent: Bool
}
