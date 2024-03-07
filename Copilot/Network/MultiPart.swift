//
//  MultiPart.swift
//  Copilot
//
//  Created by Jamal on 3/7/24.
//

import Foundation
import Alamofire

public extension Data {

    mutating func append(
        _ string: String,
        encoding: String.Encoding = .utf8
    ) {
        guard let data = string.data(using: encoding) else {
            return
        }
        append(data)
    }
}

public struct MultipartRequest {
    
    public let boundary: String
    
    private let separator: String = "\r\n"
    private var data: Data

    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        self.data = .init()
    }
    
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }
    
    private mutating func appendSeparator() {
        data.append(separator)
    }

    private func disposition(_ key: String) -> String {
        "Content-Disposition: form-data; name=\"\(key)\""
    }

    public mutating func add(
        key: String,
        value: String
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + separator)
        appendSeparator()
        data.append(value + separator)
    }

    public mutating func add(
        key: String,
//        fileName: String,
//        fileMimeType: String,
        fileData: Data
    ) {
        appendBoundarySeparator()
//        data.append(disposition(key) + "; filename=\"\(fileName)\"" + separator)
//        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        data.append(fileData)
        appendSeparator()
    }

    public var httpContentTypeHeadeValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }

    public var httpBody: Data {
        var bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
    
    static func createRequest(data: Data) -> URLRequest {
        var multipart = MultipartRequest()
        for field in [
//            "firstName": "John",
//            "lastName": "Doe"
        ] {
//            multipart.add(key: field.key, value: field.value)
        }

        multipart.add(
            key: "file",
//            fileName: "pic.jpg",
//            fileMimeType: "image/png",
            fileData: data // "fake-image-data".data(using: .utf8)!
        )
        
        let url = URL(string: "https://copilotweb.hedeffilotest.com/api/file")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(multipart.httpContentTypeHeadeValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody
        return request
        /// Fire the request using URL sesson or anything else...
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        print((response as! HTTPURLResponse).statusCode)
//        print(String(data: data, encoding: .utf8)!)
//        DispatchQueue.main.async {
//            AF.request(request).response { response in
//                let httpResponse = response.response
////                self?.handleRespone(request: request, data: response.data, response: httpResponse, error: response.error)
//                print(response)
//            }
//        }
    }
}
