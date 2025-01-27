//
//  APIService+CreateCase.swift
//  Copilot
//
//  Created by Jamal on 3/3/24.
//

import Foundation

extension APIService {
    static func createCase(supplierId: String?,
                           tireType: TireSupportType,
                           towTruck: Bool,
                           supplierName: String,
                           supplierPhone: String,
                           city: String,
                           district: String,
                           appointmentDate: Date?,
                           completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "case/appointment"
        var params = [
            "webCategory": "TIRE",
            "accidentType": "TIRE_BREAK",
            "tireSupportType": tireType.rawValue,
            "towTruck": towTruck,
            "supplierName": supplierName,
            "supplierPhone": supplierPhone,
            "city": city,
            "district": district
        ] as [String: Any]
        
        if let appointmentDate {
            let serverdate = appointmentDate.getServerDate()
            params["appointmentDate"] = serverdate
        }
        
        if let supplierId {
            params["supplierId"] = supplierId
        }
        
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "createCase"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func createMaintenanceCase(supplierId: String,
                                      supplierName: String,
                                      supplierPhone: String,
                                      city: String,
                                      district: String,
                                      appointmentDate: Date,
                                      completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let serverdate = appointmentDate.getServerDate()
        
        let route = "case/appointment"
        let params = [
            "webCategory": "MAINTENANCE",
            "accidentType": "MAINTENANCE",
            "supplierId": supplierId,
            "supplierName": supplierName,
            "supplierPhone": supplierPhone,
            "city": city,
            "district": district,
            "appointmentDate": serverdate
        ] as [String: Any]
        
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "createMaintenanceCase"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func createBreakDownCase(supplierId: String,
                                    supplierName: String,
                                    supplierPhone: String,
                                    city: String,
                                    district: String,
                                    towTruck: Bool,
                                    appointmentDate: Date?,
                                    completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "case/appointment"
        var params = [
            "webCategory": "FAILURE",
            "accidentType": "FAILURE",
            "supplierId": supplierId,
            "supplierName": supplierName,
            "supplierPhone": supplierPhone,
            "city": city,
            "towTruck": towTruck,
            "district": district
        ] as [String: Any]
        
        if let appointmentDate {
            let serverdate = appointmentDate.getServerDate()
            params["appointmentDate"] = serverdate
        }
        
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "createBreakDownCase"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func createAccidentCase(accidentType: String,
                                   reportType: AccidentReportType,
                                   supplierId: String,
                                   supplierName: String,
                                   supplierPhone: String,
                                   city: String,
                                   district: String,
                                   towTruck: Bool,
                                   appointmentDate: Date?,
                                   completion: @escaping (CreatedCaseId?, APIResponseError?) -> Void) {
        
        let route = "case/appointment"
        var params = [
            "webCategory": "DAMAGE",
            "accidentType": accidentType,
            "reportType": reportType.rawValue,
            "supplierId": supplierId,
            "supplierName": supplierName,
            "supplierPhone": supplierPhone,
            "city": city,
            "towTruck": towTruck,
            "district": district
        ] as [String: Any]
        
        if let appointmentDate {
            let serverdate = appointmentDate.getServerDate()
            params["appointmentDate"] = serverdate
        }
        
        let req = APIRequest<CreatedCaseId>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "createBreakDownCase"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
    
    static func sendAccFileInfo(caseId: String,
//                                fileInfo: [UploadRequestFile],
                                completion: @escaping (Success?, APIResponseError?) -> Void) {
        
        let route = "case/appointment/\(caseId)/document/upload"
        var list: [[String: String]] = []
        for item in accFiles {
            let object = [
                "originalFilename": item.originalFilename,
                "filename": item.filename
            ]
            list.append(object)
        }
        
        let params = [
            "files": list
        ]
        
        let req = APIRequest<Success>(route: route,
                                      method: .post,
                                      parameters: params,
                                      hasToken: true)
        req.identifier = "sendAccFileInfo"
        req.log = loggingEnabled
        req.completion = completion
        req.start()
    }
}
