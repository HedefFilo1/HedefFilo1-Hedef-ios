//
//  WarningGuideViewModel.swift
//  Copilot
//
//  Created by Jamal on 5/23/24.
//

import Foundation

struct MockWarningGuide {
    let id: Int
    let title: String
    let image: String
}

protocol WarningGuideVMCrdntrDlgt: AnyObject {
    func getBack()
    func getBackToBreakdown()
}

protocol WarningGuideVMDelegate: BaseViewModelDelegate {
    
}

protocol WarningGuideViewModelType: AnyObject {
    var coordinatorDelegate: WarningGuideVMCrdntrDlgt? { get set }
    var delegate: WarningGuideVMDelegate? { get set }
    var guides: [MockWarningGuide] { get set }
    func getBack()
    func getBackToBreakdown()
}

class WarningGuideViewModel: WarningGuideViewModelType {
    
    weak var coordinatorDelegate: WarningGuideVMCrdntrDlgt?
    weak var delegate: WarningGuideVMDelegate?
    
//    var guides: [MockWarningGuide] = [
//        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
//        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
//        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
//        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
//        
//        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
//        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
//        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
//        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
//        
//        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
//        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
//        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
//        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
//        
//        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
//        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
//        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
//        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
//        
//        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
//        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
//        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
//        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
//        
//        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
//        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
//        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
//        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
//        
//        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
//        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
//        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
//        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
//        
//        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
//        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
//        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
//        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening")
//    ]
    var guides: [MockWarningGuide] = [
        MockWarningGuide(id: 0, title: "copilotapp.warning.light.pedestrian", image: "pedestrian"),
        MockWarningGuide(id: 1, title: "copilotapp.warning.light.vehicle.door", image: "openDoor"),
        MockWarningGuide(id: 2, title: "copilotapp.warning.light.refuel", image: "gasStation"),
        MockWarningGuide(id: 3, title: "copilotapp.warning.light.battery", image: "turtle"),
        MockWarningGuide(id: 4, title: "copilotapp.warning.light.charge.battery", image: "outOfBattery"),
        MockWarningGuide(id: 5, title: "copilotapp.warning.light.seat.belt", image: "seatBelt"),
        MockWarningGuide(id: 6, title: "copilotapp.warning.light.turn.off.ignition", image: "absWarning"),
        MockWarningGuide(id: 7, title: "copilotapp.warning.light.turn.off.ignition", image: "restartWarning"),
        MockWarningGuide(id: 8, title: "copilotapp.warning.light.tire.pressure", image: "airPressure"),
        MockWarningGuide(id: 9, title: "copilotapp.warning.light.vehicle.following.distance", image: "getAwayVehicle"),
        MockWarningGuide(id: 10, title: "copilotapp.warning.light.brake.pad.failure", image: "brakePad"),
        MockWarningGuide(id: 11, title: "copilotapp.warning.light.engine", image: "checkEngine"),
        MockWarningGuide(id: 12, title: "copilotapp.warning.light.akü", image: "battery"),
        MockWarningGuide(id: 13, title: "copilotapp.warning.light.diesel", image: "dieselParticulate"),
        MockWarningGuide(id: 14, title: "copilotapp.warning.light.vehicle.error", image: "charegVehicle"),
        MockWarningGuide(id: 15, title: "copilotapp.warning.light.brake.system", image: "brakeSystem"),
        MockWarningGuide(id: 16, title: "copilotapp.warning.light.general.breakdown", image: "generalMalfunction"),
        MockWarningGuide(id: 17, title: "copilotapp.warning.light.temperature.warning", image: "temperatureWarning"),
        MockWarningGuide(id: 18, title: "copilotapp.warning.light.oil.warning", image: "oilWarning"),
        MockWarningGuide(id: 19, title: "copilotapp.warning.light.airbag.warning", image: "airbag"),
        MockWarningGuide(id: 20, title: "copilotapp.warning.light.balance.warning", image: "balance"),
        MockWarningGuide(id: 21, title: "copilotapp.warning.light.brake.pad.failure", image: "brakePadYellow"),
        MockWarningGuide(id: 22, title: "copilotapp.warning.light.lamp.warning", image: "light"),
        MockWarningGuide(id: 23, title: "copilotapp.warning.light.engine.management", image: "wire"),
        MockWarningGuide(id: 24, title: "copilotapp.warning.light.service.warning", image: "serviceWarning"),
        MockWarningGuide(id: 25, title: "copilotapp.warning.light.parking.warning", image: "park"),
        MockWarningGuide(id: 26, title: "copilotapp.warning.light.fog.lamp", image: "fogLamp"),
        MockWarningGuide(id: 27, title: "copilotapp.warning.light.washing.liquid", image: "washerFluid")
    ]
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getBackToBreakdown() {
        coordinatorDelegate?.getBackToBreakdown()
    }
}
