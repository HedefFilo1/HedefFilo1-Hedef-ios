//
//  APIRequest.swift
//
//  Created by Jamal on 7/25/23.
//

import Foundation
import SystemConfiguration

class Network {
#if DEV_DEBUG
    static let baseUrl: String = "https://copilotapp.hedeffilotest.com:4443/"
#else
    static let baseUrl: String = "https://copilotapp.hedeffilotest.com/"
#endif
    
    static func getBasicHeaders() -> [String: String] {
        return [
            "accept-language": "tr",
            "accept": "*/*",
            "Content-Type": "application/json"
        ]
    }
}

public enum Method: String {
    case get = "GET", post = "POST", patch = "PATCH", put = "PUT", delete = "DELETE"
}

struct APIResponseError {
    var code: String
    var title: String
    var message: String
    var baseErrorResponse: BaseErrorResponse?
}

struct BaseErrorResponse: Decodable {
    //    let code: String
    //    let status: String?
    let message: String
    //    let exception: BaseErrorResponseException
    let error: String
    
    var errorTitle: String {
        return error
    }
    //
    var errorMessage: String {
        //        if let validations = exception.validationErrors, validations.count > 0 {
        //            return validations[0].message
        //        }
        //        return exception.message
        return message
    }
}

struct BaseErrorResponseException: Decodable {
    let level: String
    let code: String?
    let message: String
    let validationErrors: [ValidationErrors]?
}

struct ValidationErrors: Decodable {
    let message: String
    let code: String
}

struct ResponseToken: Decodable {
    let result: ResponseTokenResult?
    
    var token: String? {
        return result?.token
    }
}

struct ResponseTokenResult: Decodable {
    let token: String?
}

protocol APIRequestConnectionDelegate: AnyObject {
    func netIsReachable(_ reachable: Bool)
}

class APIRequest<T: Decodable> {
    
    weak var connectionDelegate: APIRequestConnectionDelegate?
    
    var identifier: String?
    
    let baseURL: String
    let route: String
    var hasToken = false
    
    var url: String {
        return baseURL + route
    }
    
    let method: Method
    
    //    var completion: (T?, APIError?) -> () = { _,_  in
    //        fatalError("request has no compeletion block")
    //    }
    //
    var completion: (T?, APIResponseError?) -> Void = { _, _ in
        fatalError("request has no compeletion block")
    }
    
    public var retryOnNoConnection = true
    var retriedTimesOnNoConnection = 0
    var timeToLiveRetry = 1000
    
    var urlRequest: URLRequest?
    
    var log = false
    var jsonResponse: String?
    
    var headers: [String: String]?
    var statusCode: Int = 0
    var hasConnectionError = false
    
    //    var errorMessage: String?
    var apiResponseError: APIResponseError?
    var error: Error?
    //    var errorJson: String?
    
    var parameters: [String: Any]?
    var httpBody: Data? {
        //        return try? JSONSerialization.data(withJSONObject: parameters ?? [:])
        //
        if let parameters = parameters {
            return try? JSONSerialization.data(withJSONObject: parameters as Any)
        }
        return nil
    }
    
    var bodyString: String? {
        guard let data = httpBody else { return nil }
        return data.prettyPrintedJSONString
    }
    
    init(route: String,
         method: Method,
         parameters: [String: Any]? = nil,
         baseUrl: String = Network.baseUrl,
         headers: [String: String]? =  Network.getBasicHeaders(),
         hasToken: Bool = false) {
        
        self.route = route
        self.method = method
        self.parameters = parameters
        self.baseURL = baseUrl
        self.headers = headers
        self.hasToken = hasToken
        setToken()
    }
    
    func setToken() {
        if hasToken {
            let token = App.token ?? ""
            self.headers?[CodeStrings.authorization] = "\(CodeStrings.bearer) \(token)"
        }
        urlRequest = createURLRequest()
    }
    
    func start() {
        if isReachable() {
            if retriedTimesOnNoConnection > 0 {
                connectionDelegate?.netIsReachable(true)
                App.netIsReachable(true)
            }
            APIClient.shared.handle(request: self)
            return
        }
        retriedTimesOnNoConnection += 1
        retry(request: self)
    }
    
    func retry(request: APIRequest) {
        App.netIsReachable(false)
        connectionDelegate?.netIsReachable(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            request.start()
        }
    }
    
    func finish(_ model: T?, _ error: APIResponseError?) {
        apiResponseError = error
        completion(model, error)
    }
    
    func createURLRequest() -> URLRequest {
        
        guard let url = URL(string: url) else {
            fatalError("Can't create url request")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        if method != .get {
            urlRequest.httpBody = httpBody
        }
        urlRequest.timeoutInterval = 30
#if DEV_DEBUG
        urlRequest.timeoutInterval = 5
#endif
        return urlRequest
    }
    
    func decodeToken(data: Data) {
        //        let response = try? JSONDecoder().decode(ResponseToken.self, from: data)
        //        if let token = response?.result?.token {
        //            Persistence.token = token
        //        }
    }
    
    func decodeResponse(data: Data) {
        
#if DEV_DEBUG || DEBUG
        self.jsonResponse = data.prettyPrintedJSONString
#endif
        decodeToken(data: data)
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            finish(response, nil)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            let err = APIResponseError(code: CodeStrings.decodingResponseDataCorruptedCode,
                                       title: CodeStrings.decodingResponseDataCorruptedTitle,
                                       message: "\(context)")
            finish(nil, err)
            
        } catch let DecodingError.keyNotFound(key, context) {
            
            var message = "\(CodeStrings.decodingResponseKeyNotFoundMessage) \(key): \(context.debugDescription)"
            message += "\(CodeStrings.codingPath): \(context.codingPath)"
            
            let err = APIResponseError(code: CodeStrings.decodingResponseKeyNotFoundCode,
                                       title: CodeStrings.decodingResponseKeyNotFoundTitle,
                                       message: message)
            finish(nil, err)
            
        } catch let DecodingError.valueNotFound(value, context) {
            
            var message = "\(CodeStrings.decodingResponseValueNotFoundMessage) \(value): \(context.debugDescription)"
            message += "\(CodeStrings.codingPath): \(context.codingPath)"
            
            let err = APIResponseError(code: CodeStrings.decodingResponseValueNotFoundCode,
                                       title: CodeStrings.decodingResponseValueNotFoundTitle,
                                       message: message)
            finish(nil, err)
            
        } catch let DecodingError.typeMismatch(type, context) {
            
            var message = "\(CodeStrings.decodingResponseTypeMismatchMessage) \(type): \(context.debugDescription)"
            message += "\(CodeStrings.codingPath): \(context.codingPath)"
            
            let err = APIResponseError(code: CodeStrings.decodingResponseTypeMismatchCode,
                                       title: CodeStrings.decodingResponseTypeMismatchTitle,
                                       message: message)
            finish(nil, err)
            
        } catch {
            
            let err = APIResponseError(code: CodeStrings.decodingResponseUnknownResponseCode,
                                       title: CodeStrings.decodingResponseUnknownResponseTitle,
                                       message: error.localizedDescription)
            finish(nil, err)
        }
    }
    
    func decodeError(data: Data) {
        jsonResponse = data.prettyPrintedJSONString
        do {
            let baseErrorResponse = try JSONDecoder().decode(BaseErrorResponse.self, from: data)
            
            let err = APIResponseError(code: "",
                                       title: baseErrorResponse.errorTitle,
                                       message: baseErrorResponse.errorMessage,
                                       baseErrorResponse: baseErrorResponse)
            finish(nil, err)
            
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            let err = APIResponseError(code: CodeStrings.decodeErrorDataCorruptedCode,
                                       title: CodeStrings.decodeErrorDataCorruptedTitle,
                                       message: "\(context)")
            finish(nil, err)
            
        } catch let DecodingError.keyNotFound(key, context) {
            
            var message = "\(CodeStrings.decodeErrorKeyNotFoundMessage) \(key): \(context.debugDescription)"
            message += "\(CodeStrings.codingPath): \(context.codingPath)"
            
            let err = APIResponseError(code: CodeStrings.decodeErrorKeyNotFoundCode,
                                       title: CodeStrings.decodeErrorKeyNotFoundTitle,
                                       message: message)
            
            finish(nil, err)
            
        } catch let DecodingError.valueNotFound(value, context) {
            
            var message = "\(CodeStrings.decodeErrorValueNotFoundMessage) \(value): \(context.debugDescription)"
            message += "\(CodeStrings.codingPath): \(context.codingPath)"
            
            let err = APIResponseError(code: CodeStrings.decodeErrorValueNotFoundCode,
                                       title: CodeStrings.decodeErrorValueNotFoundTitle,
                                       message: message)
            finish(nil, err)
            
        } catch let DecodingError.typeMismatch(type, context) {
            
            var message = "\(CodeStrings.decodeErrorTypeMismatchMessage) \(type): \(context.debugDescription)"
            message += "\(CodeStrings.codingPath): \(context.codingPath)"
            
            let err = APIResponseError(code: CodeStrings.decodeErrorTypeMismatchCode,
                                       title: CodeStrings.decodeErrorTypeMismatchTitle,
                                       message: message)
            finish(nil, err)
            
        } catch {
            
            let err = APIResponseError(code: CodeStrings.decodeErrorUnknownResponseCode,
                                       title: CodeStrings.decodeErrorUnknownResponseTitle,
                                       message: error.localizedDescription)
            finish(nil, err)
        }
    }
    
    func printLog() {
        
        let start    = CodeStrings.logStart
        let nextLine = CodeStrings.logNextLine
        
        var string = "\(start)\(CodeStrings.logForIdentifier) \(identifier ?? "no id")\(nextLine)"
        string += "\(CodeStrings.url): \(url)\(nextLine)"
        string += "\(CodeStrings.method): \(method.rawValue)\(nextLine)"
        
//        if let token = headers?[CodeStrings.authorization] {
//            string += "\(CodeStrings.token): \(token)\(nextLine)"
//        }
        
        if let headers = headers {
            string += "\(CodeStrings.headers): \(headers)\(nextLine)"
        }
        
        if let body = self.bodyString, method != .get {
            string += "\(CodeStrings.body): \(body)\(nextLine)"
        }
        
        string += "\(CodeStrings.statusCode): \(statusCode)\(nextLine)"
        
        if let error = apiResponseError {
            string += "\(CodeStrings.error): \(error.title) \(error.message) \(nextLine)"
        }
        
        if let response = jsonResponse {
            string += "\(CodeStrings.response): \(response)"
        }
        
        string += "\(nextLine)"
        
        print(string)
    }
    
    func isReachable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
