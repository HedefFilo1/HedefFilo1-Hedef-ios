//
//  Reusable.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 21.07.2022.
//

import UIKit

// MARK: - Reusable Protocol
public protocol Reusable {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

// MARK: - Reusable Extension
public extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

