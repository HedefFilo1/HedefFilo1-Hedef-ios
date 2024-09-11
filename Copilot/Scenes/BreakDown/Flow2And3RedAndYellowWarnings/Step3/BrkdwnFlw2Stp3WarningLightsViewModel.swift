//
//  BrkdwnFlw2Stp3WarningLightsViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation

enum WarningType {
    case engin
    case service
    case seatBelt
    case battery
    case doors
    case pedestrain
    case airPressure
    case getAway
    case refuel
    case restart
}

enum SeverityType {
    case stopEngin
    case service
    case warning
}

class MockWarning {
    let id: Int
    let title: String
    let trTitle: String
    let image: String
    let type: WarningType
    let description: String
    var selected = false
    let severity: SeverityType
    
    init(id: Int, title: String, trTitle: String, image: String, type: WarningType, description: String, severity: SeverityType) {
        self.id = id
        self.title = title
        self.trTitle = trTitle
        self.image = image
        self.type = type
        self.description = description
        self.severity = severity
    }
    
    var message: String {
        switch type {
        case .engin:
            return App.getString(key: "copilotapp.stop.engine") ?? ""
            
        case .service:
            return Strings.serviceWarningMessage
            
        case .seatBelt:
            return Strings.seatBeltWarningMessage
            
        case .battery:
            return Strings.batteryWarningMessage
            
        case .doors:
            return Strings.doorsWarningMessage
            
        case .pedestrain:
            return Strings.pedestrianWarningMessage
            
        case .airPressure:
            return Strings.airPressureWarningMessage
            
        case .getAway:
            return Strings.getAwayWarningMessage
            
        case .refuel:
            return Strings.refuelWarningMessage
            
        case .restart:
            return Strings.restartWarningMessage
        }
    }
    
    var severiytMessage: String {
        switch severity {
        case .stopEngin:
            return App.getString(key: "copilotapp.stop.engine") ?? ""
        case .service:
            return Strings.pleaseTakeToService
        case .warning:
            return message
        }
    }
}

var allWarnings = [
    MockWarning(id: 0, title: "A Pedestrian", trTitle: "Aracın etrafında", image: "pedestrian", type: .pedestrain, description: "Aracın etrafında", severity: .warning),
    
    MockWarning(id: 1, title: "Open Door", trTitle: "Kapılarının kapalı", image: "openDoor", type: .doors, description: "Kapılarının kapalı", severity: .warning),
    
    MockWarning(id: 2, title: "Out of Oil", trTitle: "Kapılarının kapalı", image: "gasStation", type: .refuel, description: "Kapılarının kapalı", severity: .warning),
    
    MockWarning(id: 3, title: "Out of Battry", trTitle: "Batarya dolumu", image: "turtle", type: .battery, description: "Lütfen batarya dolumu yapınız", severity: .warning),
    
    MockWarning(id: 4, title: "Out of Battry", trTitle: "Batarya dolumu", image: "outOfBattery", type: .battery, description: "Lütfen batarya dolumu yapınız", severity: .warning),
    
    MockWarning(id: 5, title: "Seat Belt", trTitle: "Emniyet kemerinizi", image: "seatBelt", type: .seatBelt, description: "Lütfen emniyet kemerinizi takınız", severity: .warning),
    
    MockWarning(id: 6, title: "ABS", trTitle: "kontağı kapatıp", image: "absWarning", type: .restart, description: "Lütfen kontağı kapatıp aracı yeniden çalıştırınız", severity: .warning),
    
    MockWarning(id: 7, title: "Restart", trTitle: "kontağı kapatıp", image: "restartWarning", type: .airPressure, description: "Lütfen kontağı kapatıp aracı yeniden çalıştırınız", severity: .warning),
    
    MockWarning(id: 8, title: "Air pressure", trTitle: "lastik hava", image: "airPressure", type: .restart, description: "Lütfen kontağı kapatıp aracı yeniden çalıştırınız.", severity: .warning),
    
    MockWarning(id: 9, title: "Get Away Vehicle", trTitle: "araçla takip mesafenizi koruyunuz", image: "getAwayVehicle", type: .getAway, description: "Lütfen önünüzdeki araçla takip mesafenizi koruyunuz", severity: .warning),
    
    MockWarning(id: 10, title: "brake pad", trTitle: "brake pad", image: "brakePad", type: .engin, description: "brake pad", severity: .stopEngin),
    
    MockWarning(id: 11, title: "Check Engine", trTitle: "check Engine", image: "checkEngine", type: .engin, description: "Check Engine", severity: .stopEngin),
    
    MockWarning(id: 12, title: "Check Battery", trTitle: "akü", image: "battery", type: .engin, description: "check Battery", severity: .stopEngin),
    
    MockWarning(id: 13, title: "diesel particulate", trTitle: "dizel partikül", image: "dieselParticulate", type: .engin, description: "Dizel partikül", severity: .stopEngin),
    
    MockWarning(id: 14, title: "chareg Vehicle", trTitle: "chareg Vehicle", image: "charegVehicle", type: .engin, description: "chareg Vehicle", severity: .stopEngin),
    
    MockWarning(id: 15, title: "brake system", trTitle: "fren sistemi", image: "brakeSystem", type: .engin, description: "fren sistemi", severity: .stopEngin),
    
    MockWarning(id: 16, title: "general malfunction", trTitle: "genel arıza", image: "generalMalfunction", type: .engin, description: "genel arıza", severity: .stopEngin),
    
    MockWarning(id: 17, title: "temperature warning", trTitle: "sıcaklık uyarı", image: "temperatureWarning", type: .engin, description: "sıcaklık uyarı", severity: .stopEngin),
    
    MockWarning(id: 18, title: "oil warning", trTitle: "yağ uyarı", image: "oilWarning", type: .engin, description: "yağ uyarı", severity: .stopEngin),
    
    MockWarning(id: 19, title: "airbag", trTitle: "airbag", image: "airbag", type: .service, description: "airbag", severity: .service),
    
    MockWarning(id: 20, title: "balance", trTitle: "balans", image: "balance", type: .service, description: "balans", severity: .service),
    
    MockWarning(id: 21, title: "brake Pad", trTitle: "brake Pad", image: "brakePadYellow", type: .service, description: "brakePadYellow", severity: .service),
    
    MockWarning(id: 22, title: "light", trTitle: "lamp", image: "light", type: .service, description: "lamp", severity: .service),
    
    MockWarning(id: 23, title: "wire", trTitle: "wire", image: "wire", type: .service, description: "wire", severity: .service),
    
    MockWarning(id: 24, title: "service", trTitle: "Servis", image: "serviceWarning", type: .service, description: "service Warning", severity: .service),
    
    MockWarning(id: 25, title: "park", trTitle: "park", image: "park", type: .service, description: "park", severity: .warning),
    
    MockWarning(id: 26, title: "fog lamp", trTitle: "sis lambası", image: "fogLamp", type: .service, description: "sis lambası", severity: .service),
    
    MockWarning(id: 27, title: "washer fluid", trTitle: "yıkama sıvısı", image: "washerFluid", type: .service, description: "yıkama sıvısı", severity: .service)
]

protocol BrkdwnFlw2Stp3WarningLightsVMCrdntrDlgt: AnyObject {
    func getBack()
    func goToBrkdwnFlw2Stp4SelectedWarnings(item: MockWarning, allWarnings: [MockWarning])
    func goToWarningGuide()
}

protocol BrkdwnFlw2Stp3WarningLightsVMDelegate: BaseViewModelDelegate {
    func setBrkdwnFlw2Stp3WarningLights()
}

protocol BrkdwnFlw2Stp3WarningLightsViewModelType: AnyObject {
    var coordinatorDelegate: BrkdwnFlw2Stp3WarningLightsVMCrdntrDlgt? { get set }
    var delegate: BrkdwnFlw2Stp3WarningLightsVMDelegate? { get set }
    var warnings: [MockWarning] { get set }
    func getBack()
    func goToBrkdwnFlw2Stp4SelectedWarnings(item: MockWarning)
    func goToWarningGuide()
}

class BrkdwnFlw2Stp3WarningLightsViewModel: BrkdwnFlw2Stp3WarningLightsViewModelType {
    
    weak var coordinatorDelegate: BrkdwnFlw2Stp3WarningLightsVMCrdntrDlgt?
    weak var delegate: BrkdwnFlw2Stp3WarningLightsVMDelegate?
    var warnings: [MockWarning] = allWarnings
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToBrkdwnFlw2Stp4SelectedWarnings(item: MockWarning) {
        coordinatorDelegate?.goToBrkdwnFlw2Stp4SelectedWarnings(item: item, allWarnings: warnings)
    }
    
    func goToWarningGuide() {
        coordinatorDelegate?.goToWarningGuide()
    }
}
