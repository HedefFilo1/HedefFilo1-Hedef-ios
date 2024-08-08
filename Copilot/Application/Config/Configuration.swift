//
//  Configuration.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.08.2024.
//

import Foundation

class Configuration {
    static let shared = Configuration()

    let environment: Environment
    let appName: String
    let baseURL: String

    init() {
        environment = Environment(rawValue: Bundle.main.object(key: .configuration))!
        appName = Bundle.main.object(key: .appName)
        baseURL = Bundle.main.object(key: .baseURL)
    }
}
