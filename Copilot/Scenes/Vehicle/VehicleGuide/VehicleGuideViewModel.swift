//
//  VehicleGuideViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/24/23.
//

import Foundation

protocol VehicleGuideViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol VehicleGuideViewModelDelegate: AnyObject {
    
}

protocol VehicleGuideViewModelType: AnyObject {
    var coordinatorDelegate: VehicleGuideViewModelCoordinatorDelegate? { get set }
    var delegate: VehicleGuideViewModelDelegate? { get set }
    func getBack()
}

class VehicleGuideViewModel: VehicleGuideViewModelType {
    
    weak var coordinatorDelegate: VehicleGuideViewModelCoordinatorDelegate?
    weak var delegate: VehicleGuideViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
