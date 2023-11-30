//
//  APIService.swift
//
//  Created by Jamal on 7/25/23.
//

import Foundation
class APIService {
    
    static var loggingEnabled = true
    
    static func verifyToken(completion: @escaping (VerifyToken?, APIResponseError?) -> Void) {
        
        let req = APIRequest<VerifyToken>(route: "copilot/vehicle/status", method: .get, hasToken: true)
        req.identifier = "Verify Token"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func signup(name: String,
                       surname: String,
                       phoneNumber: String,
                       email: String,
                       plateNumber: String,
                       licenseNumber: String,
                       password: String,
                       taxId: String,
                       phonePermission: Bool,
                       smsPermission: Bool,
                       emailPermission: Bool,
                       completion: @escaping (Signup?, APIResponseError?) -> Void) {
        let params = [
            "name": name,
            "surname": surname,
            "phoneNumber": phoneNumber,
            "email": email,
            "plateNumber": plateNumber,
            "licenseNumber": licenseNumber,
            "password": password,
            "taxId": taxId,
            "phonePermission": phonePermission,
            "smsPermission": smsPermission,
            "emailPermission": emailPermission
            
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
        
        let params = [
            "email": email,
            "password": password
        ] as [String: Any]
        
        let req = APIRequest<Login>(route: "auth/copilot/login",
                                    method: .post,
                                    parameters: params)
        
        req.identifier = "Login"
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
                               phoneNumber: String,
                               completion: @escaping (ForgotPassword?, APIResponseError?) -> Void) {
        
        let params = [
            "email": email,
            "phoneNumber": phoneNumber
        ]
        
        let req = APIRequest<ForgotPassword>(route: "auth/forgot-password",
                                             method: .post,
                                             parameters: params)
        
        req.identifier = "ForgotPassword"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getProfile(completion: @escaping (GetProfile?, APIResponseError?) -> Void) {
        
        let req = APIRequest<GetProfile>(route: "copilot/profile", method: .get, hasToken: true)
        req.identifier = "Get Token"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func setPassword(old: String,
                            new: String,
                            completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let params = [
            "oldPassword": old,
            "newPassword": new
        ]
        
        let req = APIRequest<Success>(route: "user/password",
                                      method: .patch,
                                      parameters: params,
                                      hasToken: true)
        
        req.identifier = "Set Password"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getVehicle(completion: @escaping (GetVehicle?, APIResponseError?) -> Void) {
        let req = APIRequest<GetVehicle>(route: "copilot/vehicle", method: .get, hasToken: true)
        req.identifier = "Get Vehicle"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func setVehicleDistance(distance: Double,
                                   completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let params = [
            "distance": distance
        ]
        
        let req = APIRequest<Success>(route: "copilot/vehicle/distance",
                                      method: .patch,
                                      parameters: params,
                                      hasToken: true)
        
        req.identifier = "Set Vehicle Distance"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getCase(completion: @escaping ([Case]?, APIResponseError?) -> Void) {
        
        let req = APIRequest<[Case]>(route: "copilot/case", method: .get, hasToken: true)
        req.identifier = "Get Case"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getTire(completion: @escaping ([Tire]?, APIResponseError?) -> Void) {
        
        let req = APIRequest<[Tire]>(route: "copilot/tire", method: .get, hasToken: true)
        req.identifier = "Get Tire"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
}
