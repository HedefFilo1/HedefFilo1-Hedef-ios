//
//  Persist.swift
//  Katalog
//
//  Created by Fikri Can Cankurtaran on 6.08.2021.
//

import Foundation

@propertyWrapper
public struct Persist<T: Codable> {
    struct Wrapper<T>: Codable where T: Codable {
        let wrapped: T
    }
    
    let key: String
    let defaultValue: T?
    let type: PersistenceType
    
    public init(key: String, defaultValue: T? = nil, type: PersistenceType = .userDefaults) {
        self.key = key
        self.defaultValue = defaultValue
        self.type = type
    }
    
    public var wrappedValue: T? {
        get {
            if #available(iOS 13.0, *) {
                switch type {
                case .userDefaults:
                    guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                        return defaultValue
                    }
                    let value = try? JSONDecoder().decode(T.self, from: data)
                    return value ?? defaultValue
                case .keychain:
                    //                    let keychain = Keychain(service: ConstantsEnum.defaultServiceName)
                    //                    guard let data = try? keychain.getData(key) else {
                    
                    guard let data = KeychainWrapper.standard.data(forKey: key) else {
                        return defaultValue
                    }
                    let value = try? JSONDecoder().decode(T.self, from: data)
                    return value ?? defaultValue
                }
            } else {
                switch type {
                case .userDefaults:
                    guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                        return defaultValue
                    }
                    let value = try? JSONDecoder().decode(Wrapper<T>.self, from: data)
                    return value?.wrapped ?? defaultValue
                case .keychain:
                    
                    //                    let keychain = Keychain(service: ConstantsEnum.defaultServiceName)
                    //                    guard let data = try? keychain.getData(key) else {
                           
                    guard let data = KeychainWrapper.standard.data(forKey: key) else {
                        return defaultValue
                    }
                    
                    let value = try? JSONDecoder().decode(Wrapper<T>.self, from: data)
                    return value?.wrapped ?? defaultValue
                }
            }
        }
        set {
            if #available(iOS 13.0, *) {
                guard let data = try? JSONEncoder().encode(newValue) else {
                    fatalError("JSONEncoder could not encode \(String(describing: newValue))")
                }
                
                switch type {
                case .userDefaults:
                    UserDefaults.standard.set(data, forKey: key)
                case .keychain:
                    //                    let keychain = Keychain(service: ConstantsEnum.defaultServiceName)
                    //                    do {
                    //                        try keychain.set(data, key: key)
                    //                    } catch let error {
                    //                        fatalError(error.localizedDescription)
                    //                    }
                    
                    KeychainWrapper.standard.set(data, forKey: key)
                }
            } else {
                guard let data = try? JSONEncoder().encode(Wrapper(wrapped: newValue)) else {
                    fatalError("JSONEncoder could not encode \(String(describing: newValue))")
                }
                
                switch type {
                case .userDefaults:
                    UserDefaults.standard.set(data, forKey: key)
                case .keychain:
                    //                    let keychain = Keychain(service: ConstantsEnum.defaultServiceName)
                    //                    do {
                    //                        try keychain.set(data, key: key)
                    //                    } catch let error {
                    //                        fatalError(error.localizedDescription)
                    //                    }
                    KeychainWrapper.standard.set(data, forKey: key)
                }
            }
            
        }
    }
}
