//
//  APIService.swift
//
//  Created by Jamal on 7/25/23.
//

import Foundation
class APIService {
    
    static var loggingEnabled = true
    
    static func signup(nameSurname: String,
                       phoneNumber: String,
                       email: String,
                       plateNumber: String,
                       licenseNumber: String,
                       password: String,
                       taxId: String,
                       completion: @escaping (Signup?, APIResponseError?) -> Void) {
        
        let params = [
            "nameSurname": nameSurname,
             "phoneNumber": phoneNumber,
             "email": email,
             "plateNumber": plateNumber,
             "licenseNumber": licenseNumber,
             "password": password,
             "taxId": taxId
        ] as [String: Any]
        
        let req = APIRequest<Signup>(route: "auth/copilot/signup",
                                     method: .post,
                                     parameters: params)
        
        req.identifier = "Signup"
        req.log = loggingEnabled
        
        req.completion = completion
        req.start()
    }
    
    static func login(email: String,
                      password: String,
                      completion: @escaping (Login?, APIResponseError?) -> Void) {
        
//        let params = [
//            "email": email,
//            "password": password
//        ] as [String: Any]
        
        let params = [
            "email": "yunus.simsiki@solidict.com",
            "password": "asdf222"
        ] as [String: Any]
       
        
        let req = APIRequest<Login>(route: "auth/copilot/login",
                                    method: .post,
                                    parameters: params)
        
        req.identifier = "Sign In"
        req.log = loggingEnabled
        
        req.completion = { model, error in
            //            Persistence.userEmail = email
            //            Persistence.accessToken =  model?.result.accessToken
            //            Persistence.refreshToken = model?.result.refreshToken
            completion(model, error)
        }
        req.start()
    }
    
    static func forgotPassword(email: String,
                               completion: @escaping (ForgotPassword?, APIResponseError?) -> Void) {
        
        let params = [
            "email": email
        ]
        
        let req = APIRequest<ForgotPassword>(route: "auth/forgot-password",
                                             method: .post,
                                             parameters: params)
        
        req.identifier = "ForgotPassword"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
}
