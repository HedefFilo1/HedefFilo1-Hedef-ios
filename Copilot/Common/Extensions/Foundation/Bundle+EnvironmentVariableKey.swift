//
//  Bundle+EnvironmentVariableKey.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.08.2024.
//

import Foundation

extension Bundle {
    func object<T>(key: EnvironmentVariableKey) -> T {
        let object = self.object(forInfoDictionaryKey: key.rawValue)
        guard let castedObject = object as? T else {
            fatalError("Cannot cast \(String(describing: object))) to \(T.self)")
        }
        return castedObject
    }
}
