//
//  Document.swift
//  Copilot
//
//  Created by Jamal on 12/13/23.
//

import Foundation

struct Document: Decodable {
    let id: String
    let name: String
    let type: String?
}

struct DocumentContent: Decodable {
    let name: String
    let content: String
}
