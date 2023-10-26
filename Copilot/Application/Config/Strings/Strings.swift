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
    
    static var email: String {
        return localized(string: "email")
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
    
    static var mobilePhone: String {
        return localized(string: "mobilePhone")
    }
    
    static var tcTaxNumber: String {
        return localized(string: "tcTaxNumber")
    }
    
    static var taxIdNumber: String {
        return localized(string: "taxIdNumber")
    }
    
    static var plateNumber: String {
        return localized(string: "plateNumber")
    }
    
    static var vehicleLicenseNumber: String {
        return localized(string: "vehicleLicenseNumber")
    }
    
    static var marketingApprovement: String {
        return localized(string: "marketingApprovement")
    }
    
    static var sms: String {
        return localized(string: "sms")
    }
    
    static var telefon: String {
        return localized(string: "telefon")
    }
    
    static var emailPlaceholder: String {
        return localized(string: "emailPlaceholder")
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
    
    static var okay: String {
        return localized(string: "ok")
    }
    
    static var registrationTitle: String {
        return localized(string: "registrationTitle")
    }
    
    static var registerationMessage: String {
        return localized(string: "registerationMessage")
    }
    
    static var forgotPasswordDescription: String {
        return localized(string: "forgotPasswordDescription")
    }
    
    static var vknPhoneNumber: String {
        return localized(string: "vknPhoneNumber")
    }
    
    static var sendNewPassword: String {
        return localized(string: "sendNewPassword")
    }
    
    static var passwordHasBeenSent: String {
        return localized(string: "passwordHasBeenSent")
    }
    
    static var passwordSentToEmail: String {
        return localized(string: "passwordSentToEmail")
    }
    
    static var vehicleInformation: String {
        return localized(string: "vehicleInformation")
    }
    
    static var rentalPeriod: String {
        return localized(string: "rentalPeriod")
    }
    
    static var kmLimit: String {
        return localized(string: "kmLimit")
    }
    
    static var kmUsed: String {
        return localized(string: "kmUsed")
    }
    
    static var makeChange: String {
        return localized(string: "makeChange")
    }
    
    static var upcomingAppointment: String {
        return localized(string: "upcomingAppointment")
    }
    
    static var nearMe: String {
        return localized(string: "nearMe")
    }
    
    static var tireInformation: String {
        return localized(string: "tireInformation")
    }
    
    static var petlasTireService: String {
        return localized(string: "petlasTireService")
    }
    
    static var latestMaintenanceInformation: String {
        return localized(string: "latestMaintenanceInformation")
    }
    
    static var profile: String {
        return localized(string: "profile")
    }
    
    static var campaigns: String {
        return localized(string: "campaigns")
    }
    
    static var documents: String {
        return localized(string: "documents")
    }
    
    static var vehicleHGSPasses: String {
        return localized(string: "vehicleHGSPasses")
    }
    
    static var myDemands: String {
        return localized(string: "myDemands")
    }
    
    static var services: String {
        return localized(string: "services")
    }
    
    static var settings: String {
        return localized(string: "settings")
    }
    
    static var updateInformation: String {
        return localized(string: "updateInformation")
    }
    
    static var resetPassword: String {
        return localized(string: "resetPassword")
    }
    
    static var passwordsShouldBeSame: String {
        return localized(string: "passwordsShouldBeSame")
    }
    
    static var error: String {
        return localized(string: "error")
    }
    
    static var clarificationError: String {
        return localized(string: "clarificationError")
    }
    
    static var consentError: String {
        return localized(string: "consentError")
    }
    
    static var incorrectInfo: String {
        return localized(string: "incorrectInfo")
    }
    
    static var loginTryAgainMessage: String {
        return localized(string: "loginTryAgainMessage")
    }
    
    static var loading: String {
        return localized(string: "loading")
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
