//
//  APIService+Support.swift
//  Copilot
//
//  Created by Jamal on 3/20/24.
//

import Foundation
import UIKit

extension APIService {
    
    static func getFAQQuestions(completion: @escaping ([FAQQuestion]?, APIResponseError?) -> Void) {
        let route = "faq/category"
        let req = APIRequest<[FAQQuestion]>(route: route, method: .get, hasToken: true)
        req.identifier = "getFAQQuestions"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
}
