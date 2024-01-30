//
//  NotMaintenancePeriodViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation

protocol NotMaintenancePeriodVMCoordinatorDelegate: AnyObject {
    func getBack()
    func getBackToHome()
}

protocol NotMaintenancePeriodViewModelDelegate: BaseViewModelDelegate {
}

protocol NotMaintenancePeriodViewModelType: AnyObject {
    var coordinatorDelegate: NotMaintenancePeriodVMCoordinatorDelegate? { get set }
    var delegate: NotMaintenancePeriodViewModelDelegate? { get set }
    
    func getBack()
    func getAppoinment()
}

class NotMaintenancePeriodViewModel: NotMaintenancePeriodViewModelType {
    
    weak var coordinatorDelegate: NotMaintenancePeriodVMCoordinatorDelegate?
    weak var delegate: NotMaintenancePeriodViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getAppoinment() {
        
    }
    
}
