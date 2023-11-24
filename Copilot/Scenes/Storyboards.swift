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

    var filename: String {
        return rawValue.capitalizingFirstLetter()
    }
}
