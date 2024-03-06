//
//  APIService+RequestsFlow.swift
//  Copilot
//
//  Created by Jamal on 3/6/24.
//

import Foundation

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
}
