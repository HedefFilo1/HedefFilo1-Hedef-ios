//
//  APIService+PastServices.swift
//  Copilot
//
//  Created by Jamal on 3/30/24.
//

import Foundation
import UIKit

extension APIService {
    
    static func getPastMaintenaces(completion: @escaping ([PastService]?, APIResponseError?) -> Void) {
        let date = Calendar.current.date( byAdding: .month, value: -6, to: Date()) ?? Date()
        let startDate = date.getServerDate()
        let route = "case?recordTypes=MAINTENANCE&startDate=\(startDate)"
        let req = APIRequest<[PastService]>(route: route, method: .get, hasToken: true)
        req.identifier = "GetPastMaintenaces"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
}
