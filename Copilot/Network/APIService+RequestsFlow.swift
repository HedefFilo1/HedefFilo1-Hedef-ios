//
//  APIService+RequestsFlow.swift
//  Copilot
//
//  Created by Jamal on 3/6/24.
//

import Foundation
import Alamofire

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
        
        let str = data.base64EncodedString()
        
        var params = [
            "file": data
        ]
        
        let req = APIRequest<Success>(route: "",
                                      method: .post,
                                      hasToken: true)
        req.identifier = "Send File"
        req.log = loggingEnabled || true
        req.completion = completion
        req.urlRequest?.timeoutInterval = 70
//        if let url = URL(string: "https://copilotweb.hedeffilotest.com/api/file") {
//            req.urlRequest?.url = url
//        }
        
//        let encoder = JSONEncoder()
//        do {
//            let result = try encoder.encode(params)
//            req.urlRequest?.httpBody = result
//        } catch {
//            print(error)
//        }
        let request =  MultipartRequest.createRequest(data: data)
//        req.urlRequest =
////        req.start()
//        AF.upload(multipartFormData: <#T##(MultipartFormData) -> Void#>, to: <#T##URLConvertible#>, requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>)
//
//        // Send a POST request to the URL, with the data we created earlier
//        
//        let session = URLSession.shared
//           session.uploadTask(with: request, from: data, completionHandler: { responseData, response, error in
//               if error == nil {
//                   let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
//                   if let json = jsonData as? [String: Any] {
//                       print(json)
//                   }
//               }
//           }).resume()
        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(data, withName: "file")
            multipartFormData.append(data, withName: "file", fileName: "somethin.pdf", mimeType: "pdf")
          
        },
        to: "https://copilotweb.hedeffilotest.com:4443/api/file").responseDecodable(of: Success.self) { response in
            Loading.shared.hide()
                debugPrint(response)
        }
    }
    
}
