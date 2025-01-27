//
//  ProccessRequest.swift
//  Copilot
//
//  Created by Jamal on 4/5/24.
//

import Foundation

enum WebCategoryEnum: String, Decodable {
    case failur = "FAILURE"
    case damage = "DAMAGE"
    case tire = "TIRE"
    case maintenance = "MAINTENANCE"
    case invoiceObjection = "INVOICE_OBJECTION"
    case logo = "LOGO"
    case inspection = "INSPECTION"
    case ogsHgs = "OGS_HGS"
    case missingPlate = "MISSING_PLATE"
    case missingLicense = "MISSING_LICENSE"
    case foreignExit = "FOREIGN_EXIT"
    case penaltyInvoice = "PENALTY_INVOICE"
    case vehicleOccupation = "VEHICLE_OCCUPATION"
    case vehicleInspection = "VEHICLE_INSPECTION"
    case trafficPolicy = "TRAFFIC_POLICY"
    case vehicleReturn = "VEHICLE_RETURN"
    case occupiedVehicle = "OCCUPIED_VEHICLE"
    case other = "OTHER"

    var title: String {
        switch self {
        case .failur:
            return App.getString(key: "copilotapp.serviceoperation.breakdown") ?? ""
        case .damage:
            return App.getString(key: "hedefnet.demand.invoice.transaction.dropdown.damage") ?? "Hasar"
        case .tire:
            return App.getString(key: "copilotapp.serviceoperation.repair") ?? "Tamir"
        case .maintenance:
            return App.getString(key: "copilotapp.serviceoperation.maintenance") ?? "Bakım"
        case .invoiceObjection:
            return "INVOICE_OBJECTION"
        case .logo:
            return "Logo"
        case .ogsHgs:
            return App.getString(key: "copilotapp.demandprocessual.processual.demand.hgs.operation.button") ?? "OGS_HGS"
        case .missingPlate:
            return App.getString(key: "copilotapp.demandprocessual.processual.demand.lost.plate.operation.button") ?? "MISSING_PLATE"
        case .missingLicense:
            return App.getString(key: "copilotapp.demandprocessual.processual.demand.lost.license.operation.button") ?? "MISSING_LICENSE"
        case .foreignExit:
            return "FOREIGN_EXIT"
        case .penaltyInvoice:
            return "PENALTY_INVOICE"
        case .vehicleOccupation:
            return App.getString(key: "copilotapp.demandlist.product.process.request.towed.vehicle.operation") ?? "VEHICLE_OCCUPATION"
        case .vehicleInspection:
            return App.getString(key: "copilotapp.demandprocessual.processual.demand.inspection.operation.button") ?? "VEHICLE_INSPECTION"
        case .trafficPolicy:
            return "TRAFFIC_POLICY"
        case .vehicleReturn:
            return "VEHICLE_RETURN"
            
        case .occupiedVehicle:
            return App.getString(key: "copilotapp.demandlist.product.process.request.towed.vehicle.operation") ?? "Bağlanan Araç İşlemleri"
        case .inspection:
            return "INSPECTION"
            
        case .other:
            return App.getString(key: "copilotapp.other") ?? "OTHER"
        }
    }
}

struct ProccessRequest: Decodable {
    let id: String?
    let supplierName: String?
    let contactName: String?
    let plateNumber: String?
    let appointmentDate: String?
    let createdDate: String?
    let recordType: String?
    let invoiceNumber: String?
    let webCategoryEnum: WebCategoryEnum?
    let recordTypeResult: String?
    
    var displayTitle: String {
        if let recordTypeResult {
            return recordTypeResult
        }
        if let webCategoryEnum {
            return webCategoryEnum.title
        }
        
        if let supplierName {
            return supplierName
        }
        
        if let contactName {
            return contactName
        }
        
        if let plateNumber {
            return plateNumber
        }
        
        if let recordType {
            return recordType
        }
        
        if let invoiceNumber {
            return invoiceNumber
        }
        return ""
    }
    
    var existDate: String {
        if let appointmentDate {
            return appointmentDate
        }
        if let createdDate {
            return createdDate
        }
        
        return ""
    }
    
    var displayDate: String {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        formmater.locale = Locale(identifier: "tr_TR")
        if let date = formmater.date(from: existDate) {
            formmater.dateFormat = "dd.MM.yyyy"
            return formmater.string(from: date)
        }
        return ""
    }
}
