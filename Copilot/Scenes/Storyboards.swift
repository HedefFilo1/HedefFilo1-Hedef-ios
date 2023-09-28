//
//  Storyboards.swift
//  Nevita
//
//  Created by Jamal on 5/31/23.
//

import Foundation

/// The uniform place where we state all the storyboard we have in our application

enum Storyboard: String {
    case splash
    case onboarding

    var filename: String {
        return rawValue.capitalizingFirstLetter()
    }
}
