//
//  Strings.swift
//  Copilot
//
//  Created by Jamal on 9/28/23.
//

import Foundation

struct Strings {
    
    static var language = "tr-TR"
    static var dictionary: [String: AnyObject] = [:]
    
    static var welcomeToCopilot: String {
        return localized(string: "welcomeToCopilot")
    }
    
    static var welcomeMessage: String {
        return localized(string: "welcomeMessage")
    }
    
    static var carService: String {
        return localized(string: "carService")
    }
    
    static var support: String {
        return localized(string: "support")
    }
    
    static var roadAssistance: String {
        return localized(string: "roadAssistance")
    }
    
    static var moveForward: String {
        return localized(string: "moveForward")
    }
    
    static var skip: String {
        return localized(string: "skip")
    }
    
    static var login: String {
        return localized(string: "login")
    }
    
    static var ifNotMember: String {
        return localized(string: "ifNotMember")
    }
    
    static var becomeMember: String {
        return localized(string: "becomeMember")
    }
    
    static func localized(string: String) -> String {
        
        if dictionary.count == 0 {
            if let path = Bundle.main.path(forResource: "Localization", ofType: "plist") {
                dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] ?? [:]
            }
        }
        
        let key = dictionary[string] as? [String: String]
        let strKey = language == "tr-TR" ? "tr": "tr"
        let value = key?[strKey] ?? ""
        return value
    }
}
