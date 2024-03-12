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
    
    static func sendFile(data: Data, completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        //        let str = data.base64EncodedString()
        //
        //        var params = [
        //            "file": data
        //        ]
        
        let req = APIRequest<Success>(route: "",
                                      method: .post,
                                      hasToken: true)
        req.identifier = "Send File"
        req.log = loggingEnabled || true
        req.completion = completion
        req.urlRequest?.timeoutInterval = 70
        
        let image = UIImage.init(named: "logo")
        let imgdata = image!.pngData()
        var headers = Network.getBasicHeaders()
        let token = App.token ?? ""
        headers[CodeStrings.authorization] = "\(CodeStrings.bearer) \(token)"
        let httpHeader = req.urlRequest!.headers
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgdata!, withName: "file", fileName: "logo.png" , mimeType: "image/png")
        }
                  , to: "https://copilotweb.hedeffilotest.com/api/file", usingThreshold: UInt64.init(),
                  method: .post,
                  headers: httpHeader).responseDecodable(of: Success.self) { response in
            Loading.shared.hide()
            debugPrint(response)
            print(response)
        }
    }
    
}
