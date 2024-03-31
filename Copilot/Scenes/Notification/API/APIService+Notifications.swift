//
//  APIService+Notifications.swift
//  Copilot
//
//  Created by Jamal on 3/27/24.
//

import Foundation

extension APIService {
    
    static func getNotifications(completion: @escaping ([UserNotification]?, APIResponseError?) -> Void) {
        let route = "user/notification"
        let req = APIRequest<[UserNotification]>(route: route, method: .get, hasToken: true)
        req.identifier = "GetNotifications"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func readNotification(id: Int, completion: @escaping (Success?, APIResponseError?) -> Void) {
        let route = "user/notification/\(id)/read"
        let req = APIRequest<Success>(route: route, method: .patch, hasToken: true)
        req.identifier = "readNotification"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func deleteNotifications(ids: [Int], completion: @escaping (Success?, APIResponseError?) -> Void) {
        let route = "user/notification"
        let req = APIRequest<Success>(route: route, method: .delete, hasToken: true)
        req.identifier = "deleteNotifications"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
}
