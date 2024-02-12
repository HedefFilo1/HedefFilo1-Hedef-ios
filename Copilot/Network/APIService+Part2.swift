//
//  APIService+Part2.swift
//  Copilot
//
//  Created by Jamal on 2/9/24.
//

import Foundation

extension APIService {
    
    static func updateCase(caseId: String,
                           appointmentDate: Date,
                           completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let serverdate = appointmentDate.getServerDate()
        
        let route = "copilot/case"
        let params = [
            "caseId": caseId,
            "appointmentDate": serverdate
        ] as [String: Any]
        
        let req = APIRequest<Success>(route: route,
                                      method: .patch,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "createMaintenanceCase"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
    
    static func getMaintenanceEligible(kmeter: Int, completion: @escaping (GetEligible?, APIResponseError?) -> Void) {
        let route = "copilot/maintenance-eligible?km=\(kmeter)"
        let req = APIRequest<GetEligible>(route: route, method: .get, hasToken: true)
        req.identifier = "getMaintenanceEligible"
        req.log = loggingEnabled || true
        req.completion = completion
        req.start()
    }
}
