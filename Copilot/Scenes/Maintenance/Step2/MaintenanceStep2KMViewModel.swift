//
//  MaintenanceStep2KMStep2KMViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/30/24.
//

import Foundation
protocol MaintenanceStep2KMVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToNotMaintenancePeriod()
}

protocol MaintenanceStep2KMViewModelDelegate: BaseViewModelDelegate {
}

protocol MaintenanceStep2KMViewModelType: AnyObject {
    var coordinatorDelegate: MaintenanceStep2KMVMCoordinatorDelegate? { get set }
    var delegate: MaintenanceStep2KMViewModelDelegate? { get set }
    
    func getBack()
    func goToNotMaintenancePeriod()
}

class MaintenanceStep2KMViewModel: MaintenanceStep2KMViewModelType {
    
    weak var coordinatorDelegate: MaintenanceStep2KMVMCoordinatorDelegate?
    weak var delegate: MaintenanceStep2KMViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToNotMaintenancePeriod() {
        coordinatorDelegate?.goToNotMaintenancePeriod()
    }
    
}
