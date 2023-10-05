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
    
    static var yourEmailAdress: String {
        return localized(string: "yourEmailAdress")
    }
    
    static var emailIncorrect: String {
        return localized(string: "emailIncorrect")
    }
    
    static var loginDescription: String {
        return localized(string: "loginDescription")
    }
    
    static var password: String {
        return localized(string: "password")
    }
    
    static var repeatPassword: String {
        return localized(string: "repeatPassword")
    }
    
    static var forgotMyPassword: String {
        return localized(string: "forgotMyPassword")
    }
    
    static var rememberMe: String {
        return localized(string: "rememberMe")
    }
    
    static var signupDescription: String {
        return localized(string: "signupDescription")
    }
    
    static var nameSurname: String {
        return localized(string: "nameSurname")
    }
    
    static var phoneNumber: String {
        return localized(string: "phoneNumber")
    }
    
    static var tcTaxNumber: String {
        return localized(string: "tcTaxNumber")
    }
    
    static var vehicleLicenseNumber: String {
        return localized(string: "vehicleLicenseNumber")
    }
    
    static var marketingApprovement: String {
        return localized(string: "marketingApprovement")
    }
    
    static var areYouMember: String {
        return localized(string: "areYouMember")
    }
    
    static var clarificationDescription: String {
        return localized(string: "clarificationDescription")
    }
    
    static var clarificationText: String {
        return localized(string: "clarificationText")
    }
    
    static var consentDescription: String {
        return localized(string: "consentDescription")
    }
    
    static var consentText: String {
        return localized(string: "consentText")
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
