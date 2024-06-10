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
        let route = "guide/active"
        let req = APIRequest<[SupportGuide]>(route: route, method: .get, hasToken: true)
        req.identifier = "getFAQQuestions"
        req.log = loggingEnabled 
        req.completion = completion
        req.start()
    }
    
    static func getProccessRequests(completion: @escaping ([ProccessRequest]?, APIResponseError?) -> Void) {
        var route = ""
        route = "case?isTask=true&status=SOLVED"
        #if DEV_DEBUG
        route = "case?isTask=true"
        #endif
//        let route = "case"
        let req = APIRequest<[ProccessRequest]>(route: route, method: .get, hasToken: true)
        req.identifier = "GetProccessRequests"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
    
    static func getServiceOperations(completion: @escaping ([ServiceOperation]?, APIResponseError?) -> Void) {
        let route = "case?status=SOLVED&appointmentStatus=APPOINTMENT_APPROVED"
        let req = APIRequest<[ServiceOperation]>(route: route, method: .get, hasToken: true)
        req.identifier = "GetServiceOperations"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
    
    static func sendFeedBack(caseId: String,
                             rate: Int,
                             comment: String,
                             completion: @escaping (Success?, APIResponseError?) -> Void) {
        let route = "user/feedback"
        let params = [
            "caseId": caseId,
            "rate": rate,
            "comment": comment
        ] as [String: Any]
        
        let req = APIRequest<Success>(route: route,
                                                 method: .post,
                                                 parameters: params,
                                                 hasToken: true)
        req.identifier = "sendFeedBack"
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
