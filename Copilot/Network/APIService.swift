//
//  APIService.swift
//
//  Created by Jamal on 7/25/23.
//

import Foundation
import UIKit

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
    
    static func getVehicle(completion: @escaping (Vehicle?, APIResponseError?) -> Void) {
        let req = APIRequest<Vehicle>(route: "copilot/vehicle", method: .get, hasToken: true)
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
    
    static func getSupplier(mark: String, completion: @escaping ([Supplier]?, APIResponseError?) -> Void) {
        let route = "copilot/supplier?mark=\(mark)"
        let req = APIRequest<[Supplier]>(route: route, method: .get, hasToken: true)
        req.identifier = "Get Suppiler"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getTransitions(completion: @escaping ([Transition]?, APIResponseError?) -> Void) {
        let route = "copilot/transitions"
        let req = APIRequest<[Transition]>(route: route, method: .get, hasToken: true)
        req.identifier = "Get Transitions"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func getPlaces(lat: Double, lon: Double, types:[String], completion: @escaping ([Places]?, APIResponseError?) -> Void) {
        //        var route = "nearbysearch/json?location=\(lat),\(lon)&radius=\(1000)&rankby=prominence&sensor=true&key=\(CodeStrings.GMSServiceAPIKey)"
        //        let typesString = types.count > 0 ? types.joined(separator: "|") : "food"
        //        route += "&types=\(typesString)"
        //        route = route.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? route
        //
        //        let req = APIRequest<[Places]>(route: route, method: .get)
        //        req.baseURL = "https://maps.googleapis.com/maps/api/place/"
        //        req.headers = nil
        //        req.identifier = "Get Places"
        //        req.log = loggingEnabled
        //        req.completion = { model, error in
        //
        //            completion(model, error)
        //        }
        //        req.start()
        
        var placesTask: URLSessionDataTask?
        
        var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lon)&radius=\(1000)&rankby=prominence&sensor=true&key=\(CodeStrings.googlePlacesAPIKey)"
        let typesString = types.count > 0 ? types.joined(separator: "|") : "food"
        urlString += "&types=\(typesString)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString
        
        guard let url = URL(string: urlString) else { return}
        
        placesTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            completion(nil, nil)
            print(data)
        }
        
        placesTask?.resume()
    }
}
