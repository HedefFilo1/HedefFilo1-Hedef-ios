//
//  StoryboardIdentifiable.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 21.07.2022.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
