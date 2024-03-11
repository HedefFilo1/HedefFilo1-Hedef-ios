//
//  Storyboards.swift
//
//  Created by Jamal on 5/31/23.
//

import Foundation

/// The uniform place where we state all the storyboard we have in our application

enum Storyboard: String {
    case splash
    case onboarding
    case login
    case popup
    case main
    case home
    case profile
    case vehicle
    case services
    case tire
    case maintenance
    case breakDown
    case accident
    case requests
    case settings

    var filename: String {
        return rawValue.capitalizingFirstLetter()
    }
}
