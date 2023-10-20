//
//  APIClient.swift
//  
//
//  Created by Jamal on 7/25/23.
//

import Foundation

struct VoidResponse<T: Decodable> {
    init() {}
}

extension Foundation.Notification.Name {
    static let didReceive401 = Foundation.Notification.Name(CodeStrings.didReceiveUnauthorizedError)
}

final class APIClient {
    
    private var session: URLSession = URLSession.shared
    
    private var unauthorizedNotification = Foundation.Notification(name: .didReceive401)
    
    static var shared = APIClient()
    
    func handle<T: Decodable> (request: APIRequest<T>) {
        guard let urlRequest = request.urlRequest else { return }
        
        let task = session.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                self?.handleRespone(request: request, data: data, response: httpResponse, error: error)
            }
            
        })
        
        task.resume()
    }
    
    // swiftlint:disable cyclomatic_complexity
    func handleRespone<T: Decodable>(request: APIRequest<T>,
                                     data: Data?,
                                     response: HTTPURLResponse?,
                                     error: Error?) {
        
        defer {
#if DEV_DEBUG || DEBUG
            if request.log {
                request.printLog()
            }
#endif
        }
        
        guard error == nil else {
            request.hasConnectionError = true
            request.error = error
            let error = APIResponseError(code: CodeStrings.networkErrorCode,
                                         title: CodeStrings.networkErrorCodeTitle,
                                         message: CodeStrings.networkErrorCodeMessage)
            request.finish(nil, error)
            return
        }
        
        guard let response = response else {
            let error = APIResponseError(code: CodeStrings.noJSONDataErrorCode,
                                         title: CodeStrings.noJSONDataErrorTitle,
                                         message: CodeStrings.noJSONDataErrorMessage)
            request.finish(nil, error)
            //            request.completion(nil, .noJSONData)
            return
        }
        
#if DEV_DEBUG || DEBUG
        request.jsonResponse = data?.prettyPrintedJSONString
#endif
        
        request.statusCode = response.statusCode
        
//        if response.statusCode == 401 {
//            NotificationCenter.default.post(unauthorizedNotification)
//        }
        
        switch response.statusCode {
        case 200...299:
            guard let data = data, data.count > 0 else {
                request.finish(nil, nil)
                //                let error = APIResponseError(code: "response.statusCode", title: "Success whit No response Data", message: "Response is nil and There is no JSON data")
                return
            }
            request.decodeResponse(data: data)
            
        case 400...499:
            guard data != nil else {
                let error = APIResponseError(code: "\(response.statusCode)",
                                             title: "\(CodeStrings.dataIsNilErrorTitle) \(response.statusCode)",
                                             message: CodeStrings.dataIsNilErrorMessage)
                request.finish(nil, error)
                return
            }
            if response.statusCode == 401 {
                let error = APIResponseError(code: "\(response.statusCode)",
                                             title: "\(CodeStrings.tokenIsNotValidErrorTitle) \(response.statusCode)",
                                             message: CodeStrings.tokenIsNotValidErrorMessage)
                request.apiResponseError = error
                
                // Add this for now
                if let data = data, data.count > 0 {
                    request.decodeError(data: data)
                    return
                }
                // Add this for now
//                request.finish(nil, error)
//                App.refreshToken(request: request)
                return
                
            } else {
                guard let data = data, data.count > 0 else {
                    let error = APIResponseError(code: CodeStrings.noJSONDataErrorCode,
                                                 title: CodeStrings.noJSONDataErrorTitle,
                                                 message: CodeStrings.noJSONDataErrorMessage)
                    request.finish(nil, error)
                    return
                }
                
                request.decodeError(data: data)
            }
        case 500...599:
            
            if let data = data, data.count > 0,
               (try? JSONDecoder().decode(BaseErrorResponse.self, from: data)) != nil {
                request.decodeError(data: data)
                return
            }
            
            let error = APIResponseError(code: "\(response.statusCode)",
                                         title: "\(CodeStrings.internalServerError): \(response.statusCode)",
                                         message: CodeStrings.internalServerError)
            request.finish(nil, error)
            
        default:
            guard let data = data, data.count > 0 else {
                let error = APIResponseError(code: CodeStrings.responseIsNilErrorCode,
                                             title: CodeStrings.responseIsNilErrorTitle,
                                             message: CodeStrings.responseIsNilErrorMessage)
                request.finish(nil, error)
                return
            }
            
            let error = APIResponseError(code: "\(response.statusCode)",
                                         title: "\(CodeStrings.unknownError)",
                                         message: CodeStrings.unknownError)
            request.finish(nil, error)
        }
        
    }
    
    // swiftlint:enable cyclomatic_complexity
    
}
