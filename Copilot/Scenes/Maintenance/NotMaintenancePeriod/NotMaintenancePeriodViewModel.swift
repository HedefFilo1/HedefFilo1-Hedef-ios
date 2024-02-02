//
//  NotMaintenancePeriodViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation

protocol NotMaintenancePeriodVMCoordinatorDlgt: AnyObject {
    func getBack()
    func getBackToHome()
}

protocol NotMaintenancePeriodViewModelDelegate: BaseViewModelDelegate {
}

protocol NotMaintenancePeriodViewModelType: AnyObject {
    var coordinatorDelegate: NotMaintenancePeriodVMCoordinatorDlgt? { get set }
    var delegate: NotMaintenancePeriodViewModelDelegate? { get set }
    var nextMaintenanceKm: Int { get set }
    var userInputKm: Int { get set }
    var remainingKM: Int { get}
    
    func getBack()
    func getAppoinment()
}

class NotMaintenancePeriodViewModel: NotMaintenancePeriodViewModelType {
    
    weak var coordinatorDelegate: NotMaintenancePeriodVMCoordinatorDlgt?
    weak var delegate: NotMaintenancePeriodViewModelDelegate?
    var nextMaintenanceKm: Int = 0
    var userInputKm: Int = 0
    
    var remainingKM: Int {
        return nextMaintenanceKm - userInputKm
    }
    
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getAppoinment() {
        
    }
    
}
