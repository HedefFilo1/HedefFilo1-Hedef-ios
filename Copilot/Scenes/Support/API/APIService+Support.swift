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
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func getFAQQuestion(categoryId: Int, completion: @escaping ([FAQQuestionDetail]?, APIResponseError?) -> Void) {
        let route = "faq/category/\(categoryId)/question"
        let req = APIRequest<[FAQQuestionDetail]>(route: route, method: .get, hasToken: true)
        req.identifier = "getFAQQuestion"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func getSupportGuides(completion: @escaping ([SupportGuide]?, APIResponseError?) -> Void) {
        let route = "guide"
        let req = APIRequest<[SupportGuide]>(route: route, method: .get, hasToken: true)
        req.identifier = "getFAQQuestions"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func getProccessRequests(completion: @escaping ([SupportGuide]?, APIResponseError?) -> Void) {
        let route = "case?isTask=true&status=SOLVED"
        let req = APIRequest<[SupportGuide]>(route: route, method: .get, hasToken: true)
        req.identifier = "GetProccessRequests"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
    
    static func getServiceOperations(completion: @escaping ([SupportGuide]?, APIResponseError?) -> Void) {
        let route = "case?status=SOLVED&appointmentStatus=APPOINTMENT_APPROVED"
        let req = APIRequest<[SupportGuide]>(route: route, method: .get, hasToken: true)
        req.identifier = "GetServiceOperations"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
    
    static func getLiveSupport(completion: @escaping (LiveSupport?, APIResponseError?) -> Void) {
        let route = "live-support"
        let req = APIRequest<LiveSupport>(route: route, method: .get, hasToken: true)
        req.identifier = "GetLiveSupport"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
}
