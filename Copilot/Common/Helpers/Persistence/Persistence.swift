//
//  Persistence.swift
//  Katalog
//
//  Created by Fikri Can Cankurtaran on 6.08.2021.
//

import Foundation

struct Persistence {
    @Persist(key: "AccessToken", defaultValue: nil, type: .keychain)
    static var accessToken: String?
    
    @Persist(key: "Password", defaultValue: nil, type: .keychain)
    static var password: String?
    
    @Persist(key: "OnboardingHasShown", defaultValue: nil, type: .userDefaults)
    static var onboardingHasShown: Bool?
    
    @Persist(key: "UserEmail", defaultValue: nil, type: .userDefaults)
    static var userEmail: String?
    
    @Persist(key: "RememberMe", defaultValue: nil, type: .userDefaults)
    static var rememberMe: Bool?
    
    @Persist(key: "Language", defaultValue: nil, type: .userDefaults)
    static var language: String?
    
    @Persist(key: "AvatarSelected", defaultValue: nil, type: .userDefaults)
    static var avatarSelected: String?
}
