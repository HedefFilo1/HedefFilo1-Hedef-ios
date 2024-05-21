//
//  APIService+Part2.swift
//  Copilot
//
//  Created by Jamal on 2/9/24.
//

import Foundation
import UIKit

extension APIService {
    
    static func updateCase(caseId: String,
                           appointmentDate: Date,
                           completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let serverdate = appointmentDate.getServerDate()
        
        let route = "case/appointment"
        let params = [
            "caseId": caseId,
            "appointmentDate": serverdate
        ] as [String: Any]
        
        let req = APIRequest<Success>(route: route,
                                      method: .patch,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "createMaintenanceCase"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getMaintenanceEligible(kmeter: Int, completion: @escaping (GetEligible?, APIResponseError?) -> Void) {
        let route = "copilot/maintenance-eligible?km=\(kmeter)"
        let req = APIRequest<GetEligible>(route: route, method: .get, hasToken: true)
        req.identifier = "getMaintenanceEligible"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getSessionId(completion: @escaping (GetSessionId?, APIResponseError?) -> Void) {
        let route = "user/action/session"
        let req = APIRequest<GetSessionId>(route: route, method: .get, hasToken: true)
        req.identifier = "getSessionId"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func addUserAction(pageName: String, actionName: String) {
        let phoneModel = UIDevice.modelName
        let osVersion = UIDevice.current.systemVersion
        let route = "user/action"
        let params = [
            "sessionId": App.sessionId ?? "",
            "pageName": pageName,
            "actionName": actionName,
            "platformType": "COPILOT",
            "deviceType": "MOBILE",
            "deviceOS": "IOS",
            "deviceDetail": phoneModel,
            "deviceOsDetail": osVersion
        ] as [String: Any]
        
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "addUserAction"
        req.log = true // loggingEnabled 
        req.completion = { _, error in
        
            #if DEV_DEBUG
            if let error = error {
                fatalError("user acction 500 error")
            }
            if let error = error, error.code.contains("500") {
                fatalError("user acction 500 error")
            }
            #endif
        }
        req.start()
    }
    
    static func getNotificationPreferences(completion: @escaping ([NotificationPreference]?, APIResponseError?) -> Void) {
        let route = "user/notification-preference"
        let req = APIRequest<[NotificationPreference]>(route: route, method: .get, hasToken: true)
        req.identifier = "getNotificationPreferences"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func setNotificationPreferences(type: NotificationPreferenceType,
                                           enabled: Bool,
                                           completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "user/notification-preference/\(type.rawValue)"
        let params = [
            "enabled": enabled
        ]
        
        let req = APIRequest<Success>(route: route,
                                      method: .patch,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "setNotificationPreferences"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func getTotalPoints(completion: @escaping (TotalPoints?, APIResponseError?) -> Void) {
        let route = "user/point/sum"
        let req = APIRequest<TotalPoints>(route: route, method: .get, hasToken: true)
        req.identifier = "getTotalPoints"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func getBarPoints(completion: @escaping ([BarPoint]?, APIResponseError?) -> Void) {
        let route = "point/bar"
        let req = APIRequest<[BarPoint]>(route: route, method: .get, hasToken: true)
        req.identifier = "getCarPoints"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func getCarPoint(completion: @escaping ([BarPoint]?, APIResponseError?) -> Void) {
        let route = "user/point/all-sum"
        let req = APIRequest<[BarPoint]>(route: route, method: .get, hasToken: true)
        req.identifier = "getCarPoint"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
}
