//
//  Environment.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.08.2024.
//

import Foundation

enum Environment: String {
    case debugDevelopment = "Debug Development"
    case releaseDevelopment = "Release Development"

    case debugProduction = "Debug Production"
    case releaseProduction = "Release Production"
}

enum EnvironmentVariableKey: String {
    case configuration = "CONFIGURATION"
    case appName = "APP_NAME"
    case baseURL = "BASE_URL"
}
