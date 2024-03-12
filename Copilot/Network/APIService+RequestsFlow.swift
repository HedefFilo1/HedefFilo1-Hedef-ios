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
                
            case .failure(_):
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
                              deliveryAddress: String,
                              fileInfo: UploadRequestFile?,
                              completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "case/request"
        var params = [
            "webCategory": "OGS_HGS",
            "licensePlate": licensePlate,
            "note": note,
            "nameSurname": nameSurname,
            "receiverPersonName": receiverPersonName,
            "receiverPersonPhone": receiverPersonPhone,
            "deliveryAddress": deliveryAddress
        ] as [String: Any]
        
        if let fileInfo {
            params["files"] = [
                "originalFilename": fileInfo.originalFilename,
                "filename": fileInfo.filename,
            ]
        }
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "CreateHGSCase"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
    
}
