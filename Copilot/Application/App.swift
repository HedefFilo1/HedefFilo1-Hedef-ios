//
//  App.swift
//
//  Created by Jamal on 7/7/23.
//

import Foundation
import UIKit

class App {
    
    static var window: UIWindow!
    static weak var appCoordinator: AppCoordinator?
    static var deepLinkURL: URL?
    static var token: String?
    static var vehicle: Vehicle?
    static var contentStrings: [ContentString]?
    
    static var appLoaded = false {
        didSet {
            if appLoaded, let url = deepLinkURL {
                handleDeepLink(url: url)
            }
        }
    }
    
    static func netIsReachable(_ reachable: Bool) {
//        
    }
    
//    static var appLanguage: String {
//        guard let lan = Persistence.language else {
//            return initialzeAppLanguage()
//        }
//        return lan
//    }
    
//    static func initialzeAppLanguage() -> String {
//        let lang = Locale.preferredLanguages.first ?? ""
//        let selected = lang.contains(CodeStrings.ttr) ? CodeStrings.trTr: CodeStrings.enUS
//        Persistence.language = selected
//        return selected
//    }
    
//    static func refreshToken<T: Decodable>(request: APIRequest<T>) {
//
//        APIService.refreshToken { model, error in
//
//            if model != nil {
//                request.setToken()
//                request.start()
//            } else if let error = error {
//                print(error)
//                appCoordinator?.restart()
//            }
//        }
//    }
}

// MARK: Handle DeepLink
extension App {
    
    static func handleDeepLink(url: URL) {
        deepLinkURL = url
        
        if appLoaded {
//            appCoordinator?.loadDeepLink(url: url)
            deepLinkURL = nil
        }
    }
    
}

// MARK: String
extension App {
    static func getString(key: String) -> String? {
        return contentStrings?.filter({$0.strKey == key && $0.lang == CodeStrings.trKey}).first?.strValue
    }
}
