//
//  APIService+PastServices.swift
//  Copilot
//
//  Created by Jamal on 3/30/24.
//

import Foundation
import UIKit

extension APIService {
    
    static func getPastServices(type: String, completion: @escaping ([PastService]?, APIResponseError?) -> Void) {
        let date = Calendar.current.date( byAdding: .day, value: -180, to: Date()) ?? Date()
        let startDate = date.getServerDate()
        let route = "case?recordType=\(type)&status=SOLVED&appointmentStatus=APPOINTMENT_APPROVED&startDate=\(startDate)"
        let req = APIRequest<[PastService]>(route: route, method: .get, hasToken: true)
        req.identifier = "GetPastServices"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
}
