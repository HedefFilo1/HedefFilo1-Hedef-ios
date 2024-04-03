//
//  APIService+RequestsFlow.swift
//  Copilot
//
//  Created by Jamal on 3/6/24.
//

import Foundation
import Alamofire
import UIKit

extension APIService {
    
    static func createTask(subjects: [String],
                           completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        struct TaskSubject: Encodable {
            let subject: String
        }
        
        let route = "task"
        var params = [TaskSubject]()
        for item in subjects {
            params.append(TaskSubject(subject: item))
        }
        
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      hasToken: true)
        
        let encoder = JSONEncoder()
        do {
            let result = try encoder.encode(params)
            req.urlRequest?.httpBody = result
        } catch {
            print(error)
        }
        
        req.identifier = "Create Task"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
    
    static func getTasks(completion: @escaping ([Task]?, APIResponseError?) -> Void) {
        let route = "task"
        let req = APIRequest<[Task]>(route: route, method: .get, hasToken: true)
        req.identifier = "getTasks"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func cancelTask(id: String, completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "task/\(id)"
        let req = APIRequest<Success>(route: route,
                                      method: .delete,
                                      hasToken: true)
        
        req.identifier = "Cancel Task"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func sendFile(data: Data, completion: @escaping (UploadRequestFile?, APIResponseError?) -> Void) {
        
        let req = APIRequest<UploadRequestFile>(route: "",
                                                method: .post,
                                                hasToken: true)
        
        guard let httpHeader = req.urlRequest?.headers else { return }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data,
                                     withName: "file",
                                     fileName: "OriginalFileName.png",
                                     mimeType: "image/png")
            
        }, to: "https://copilotweb.hedeffilotest.com/api/file",
                  method: .post,
                  headers: httpHeader).responseDecodable(of: UploadRequestFile.self) { response in
            debugPrint(response)
            switch response.result {
            case .success(let model):
                completion(model, nil)
                
            case .failure:
                let resError = APIResponseError(code: "777", title: "Upload Error", message: "Please Check your file and its Size.")
                completion(nil, resError)
            }
        }
    }
    
    static func createHGSCase(licensePlate: String,
                              note: String,
                              nameSurname: String,
                              receiverPersonName: String,
                              receiverPersonPhone: String,
                              receiverPersonEmail: String,
                              ogsHgsType: String,
                              deliveryAddress: String,
                              fileInfo: UploadRequestFile?,
                              completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "case/request"
        var params = [
            "webCategory": "OGS_HGS",
            "ogsHgsType": ogsHgsType,
            "licensePlate": licensePlate,
            "note": note,
            "nameSurname": nameSurname,
            "receiverPersonName": receiverPersonName,
            "receiverPersonPhone": receiverPersonPhone,
            "receiverPersonEmail": receiverPersonEmail,
            "deliveryAddress": deliveryAddress
        ] as [String: Any]
        
        if let fileInfo {
            let object = [
                "originalFilename": fileInfo.originalFilename,
                "filename": fileInfo.filename
            ]
            let list = [object]
            params["files"] = list
        }
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "CreateHGSCase"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func createVehicleCase(licensePlate: String,
                                  note: String,
                                  nameSurname: String,
                                  impoundCarReason: String,
                                  description: String,
                                  trafficBranchName: String,
                                  trafficBranchPhone: String,
                                  carParkName: String,
                                  carParkPhone: String,
                                  deliveryPersonName: String,
                                  deliveryPersonPhone: String,
                                  city: String,
                                  deliveryAddress: String,
                                  fileInfo: UploadRequestFile?,
                                  completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "case/request"
        var params = [
            "webCategory": "OCCUPIED_VEHICLE",
            "licensePlate": licensePlate,
            "note": note,
            "nameSurname": nameSurname,
            "impoundCarReason": impoundCarReason,
            //            "description": description,
            "trafficBranchName": trafficBranchName,
            "trafficBranchPhone": trafficBranchPhone,
            "carParkName": carParkName,
            "carParkPhone": carParkPhone,
            "deliveryPersonName": deliveryPersonName,
            "deliveryPersonPhone": deliveryPersonPhone,
            "city": city
            //            "deliveryAddress": deliveryAddress
        ] as [String: Any]
        
        if let fileInfo {
            let object = [
                "originalFilename": fileInfo.originalFilename,
                "filename": fileInfo.filename
            ]
            let list = [object]
            params["files"] = list
        }
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "CreateVehicleCase"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func createPlateCase(licensePlate: String,
                                note: String,
                                kmValue: Int,
                                description: String,
                                nameSurname: String,
                                numberPlate: Int,
                                deliveryPersonName: String,
                                deliveryPersonPhone: String,
                                deliveryAddress: String,
                                fileInfo: UploadRequestFile?,
                                completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "case/request"
        var params = [
            "webCategory": "MISSING_PLATE",
            "licensePlate": licensePlate,
            "note": note,
            "km": kmValue,
            "description": description,
            "nameSurname": nameSurname,
            "numberPlate": numberPlate,
            "deliveryPersonName": deliveryPersonName,
            "deliveryPersonPhone": deliveryPersonPhone,
            "deliveryAddress": deliveryAddress
        ] as [String: Any]
        
        if let fileInfo {
            let object = [
                "originalFilename": fileInfo.originalFilename,
                "filename": fileInfo.filename
            ]
            let list = [object]
            params["files"] = list
        }
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "CreatePlateCase"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func createLicenseCase(licensePlate: String,
                                  note: String,
                                  kmValue: Int,
                                  description: String,
                                  nameSurname: String,
                                  deliveryPersonName: String,
                                  deliveryPersonPhone: String,
                                  deliveryAddress: String,
                                  fileInfo: UploadRequestFile?,
                                  completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "case/request"
        var params = [
            "webCategory": "MISSING_LICENSE",
            "licensePlate": licensePlate,
            "note": note,
            "km": kmValue,
            //            "description": description,
            "nameSurname": nameSurname,
            "deliveryPersonName": deliveryPersonName,
            "deliveryPersonPhone": deliveryPersonPhone,
            "deliveryAddress": deliveryAddress
        ] as [String: Any]
        
        if let fileInfo {
            let object = [
                "originalFilename": fileInfo.originalFilename,
                "filename": fileInfo.filename
            ]
            let list = [object]
            params["files"] = list
        }
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "CreateLicenseCase"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func createInspectionCase(licensePlate: String,
                                     note: String,
                                     nameSurname: String,
                                     receiverPersonName: String,
                                     receiverPersonTC: String,
                                     fileInfo: UploadRequestFile?,
                                     completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "case/request"
        var params = [
            "webCategory": "VEHICLE_INSPECTION",
            "licensePlate": licensePlate,
            "note": note,
            "nameSurname": nameSurname,
            "receiverPersonName": receiverPersonName,
            "receiverPersonTC": receiverPersonTC
            
        ] as [String: Any]
        
        if let fileInfo {
            let object = [
                "originalFilename": fileInfo.originalFilename,
                "filename": fileInfo.filename
            ]
            let list = [object]
            params["files"] = list
        }
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "CreateInspectionCase"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func getRequests(completion: @escaping ([Demand]?, APIResponseError?) -> Void) {
        let route = "case?isTask=true"
        let req = APIRequest<[Demand]>(route: route, method: .get, hasToken: true)
        req.identifier = "getSessionId"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
}
