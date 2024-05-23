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
    
    var guides: [MockWarningGuide] = [
        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
        
        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
        
        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
        
        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
        
        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
        
        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
        
        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
        
        MockWarningGuide(id: 0, title: "Charging Light", image: "batteryCharge"),
        MockWarningGuide(id: 1, title: "Brake System", image: "brakeSystemGuid"),
        MockWarningGuide(id: 2, title: "Catalytic Coverter", image: "CatalyticCoverter"),
        MockWarningGuide(id: 3, title: "Distance Waening", image: "DistanceWaening"),
    ]
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getBackToBreakdown() {
        coordinatorDelegate?.getBackToBreakdown()
    }
}
