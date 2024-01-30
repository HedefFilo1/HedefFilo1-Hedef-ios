//
//  MaintenanceViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/30/24.
//

import Foundation

protocol MaintenanceVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToFlow1Step2NewMaintenance()
//    func goToServiceDetail(service: Supplier?, appointment: Case?, MaintenanceSupportType: MaintenanceSupportType?)
}

protocol MaintenanceViewModelDelegate: BaseViewModelDelegate {
    func setMaintenance()
}

protocol MaintenanceViewModelType: AnyObject {
    var coordinatorDelegate: MaintenanceVMCoordinatorDelegate? { get set }
    var delegate: MaintenanceViewModelDelegate? { get set }
    var appointment: Case? { get set }
    func getBack()
    func getAppoinment()
}

class MaintenanceViewModel: MaintenanceViewModelType {
    
    weak var coordinatorDelegate: MaintenanceVMCoordinatorDelegate?
    weak var delegate: MaintenanceViewModelDelegate?
    var appointment: Case?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getAppoinment() {
        
    }
    
}
