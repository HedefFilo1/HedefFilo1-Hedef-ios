//
//  BrkdwnFlw2Stp3WarningLightsViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation

class MockWarning {
    let id: Int
    let title: String
    let trTitle: String
    let image: String
    let isRed: Bool
    let description: String
    var selected = false
    init(id: Int, title: String, trTitle: String, image: String, isRed: Bool, description: String) {
        self.id = id
        self.title = title
        self.trTitle = trTitle
        self.image = image
        self.isRed = isRed
        self.description = description
    }
}

var allWarnings = [
    MockWarning(id: 0, title: "A Pedestrian", trTitle: "Aracın etrafında", image: "pedestrian", isRed: false, description: "Aracın etrafında"),
    
    MockWarning(id: 1, title: "Open Door", trTitle: "Kapılarının kapalı", image: "openDoor", isRed: true, description: "Kapılarının kapalı"),
    
    MockWarning(id: 2, title: "Out of Oil", trTitle: "Kapılarının kapalı", image: "gasStation", isRed: false, description: "Kapılarının kapalı"),
    
    MockWarning(id: 3, title: "Out of Battry", trTitle: "Batarya dolumu", image: "turtle", isRed: false, description: "Lütfen batarya dolumu yapınız"),
    
    MockWarning(id: 4, title: "Out of Battry", trTitle: "Batarya dolumu", image: "outOfBattery", isRed: true, description: "Lütfen batarya dolumu yapınız"),
    
    MockWarning(id: 5, title: "Seat Belt", trTitle: "Emniyet kemerinizi", image: "seatBelt", isRed: true, description: "Lütfen emniyet kemerinizi takınız"),
    
    MockWarning(id: 6, title: "ABS", trTitle: "kontağı kapatıp", image: "absWarning", isRed: false, description: "Lütfen kontağı kapatıp aracı yeniden çalıştırınız"),
    
    MockWarning(id: 7, title: "Restart", trTitle: "kontağı kapatıp", image: "restartWarning", isRed: false, description: "Lütfen kontağı kapatıp aracı yeniden çalıştırınız"),
    
    MockWarning(id: 8, title: "Air pressure", trTitle: "lastik hava", image: "airPressure", isRed: false, description: "Lütfen lastik hava basıncını kontrol ediniz"),
    
    MockWarning(id: 9, title: "Get Away Vehicle", trTitle: "araçla takip mesafenizi koruyunuz", image: "getAwayVehicle", isRed: true, description: "Lütfen önünüzdeki araçla takip mesafenizi koruyunuz"),
    
    MockWarning(id: 10, title: "brake pad", trTitle: "brake pad", image: "brakePad", isRed: true, description: "brake pad"),
    
    MockWarning(id: 11, title: "Check Engine", trTitle: "check Engine", image: "checkEngine", isRed: false, description: "Check Engine"),
    
    MockWarning(id: 12, title: "Check Battery", trTitle: "akü", image: "battery", isRed: true, description: "check Battery"),
    
    MockWarning(id: 13, title: "diesel particulate", trTitle: "dizel partikül", image: "dieselParticulate", isRed: false, description: "Dizel partikül"),
    
    MockWarning(id: 14, title: "chareg Vehicle", trTitle: "chareg Vehicle", image: "charegVehicle", isRed: false, description: "chareg Vehicle"),
    
    MockWarning(id: 15, title: "brake system", trTitle: "fren sistemi", image: "brakeSystem", isRed: true, description: "fren sistemi"),
    
    MockWarning(id: 16, title: "general malfunction", trTitle: "genel arıza", image: "generalMalfunction", isRed: true, description: "genel arıza"),
    
    MockWarning(id: 17, title: "temperature warning", trTitle: "sıcaklık uyarı", image: "temperatureWarning", isRed: true, description: "sıcaklık uyarı"),
    
    MockWarning(id: 18, title: "oil warning", trTitle: "yağ uyarı", image: "oilWarning", isRed: true, description: "yağ uyarı"),
    
    MockWarning(id: 19, title: "airbag", trTitle: "airbag", image: "airbag", isRed: true, description: "airbag"),
    
    MockWarning(id: 20, title: "balance", trTitle: "balans", image: "balance", isRed: false, description: "balans"),
    
    MockWarning(id: 21, title: "brake Pad", trTitle: "brake Pad", image: "brakePadYellow", isRed: false, description: "brakePadYellow"),
    
    MockWarning(id: 22, title: "light", trTitle: "lamp", image: "light", isRed: false, description: "lamp"),
    
    MockWarning(id: 23, title: "wire", trTitle: "wire", image: "wire", isRed: false, description: "wire"),
    
    MockWarning(id: 24, title: "service", trTitle: "Servis", image: "serviceWarning", isRed: false, description: "service Warning"),
    
    MockWarning(id: 25, title: "park", trTitle: "park", image: "park", isRed: true, description: "park"),
    
    MockWarning(id: 26, title: "fog lamp", trTitle: "sis lambası", image: "fogLamp", isRed: false, description: "sis lambası"),
    
    MockWarning(id: 27, title: "washer fluid", trTitle: "yıkama sıvısı", image: "washerFluid", isRed: false, description: "yıkama sıvısı")
]

protocol BrkdwnFlw2Stp3WarningLightsVMCrdntrDlgt: AnyObject {
    func getBack()
    func goToBrkdwnFlw2Stp4SelectedWarnings(item: MockWarning, allWarnings: [MockWarning])
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
}
