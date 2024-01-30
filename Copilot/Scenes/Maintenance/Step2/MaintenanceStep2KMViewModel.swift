//
//  MaintenanceStep2KMStep2KMViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/30/24.
//

import Foundation
protocol MaintenanceStep2KMVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToFlow1Step2NewMaintenanceStep2KM()
}

protocol MaintenanceStep2KMViewModelDelegate: BaseViewModelDelegate {
}

protocol MaintenanceStep2KMViewModelType: AnyObject {
    var coordinatorDelegate: MaintenanceStep2KMVMCoordinatorDelegate? { get set }
    var delegate: MaintenanceStep2KMViewModelDelegate? { get set }
    var appointment: Case? { get set }
    func getBack()
    func getAppoinment()
}

class MaintenanceStep2KMViewModel: MaintenanceStep2KMViewModelType {
    
    weak var coordinatorDelegate: MaintenanceStep2KMVMCoordinatorDelegate?
    weak var delegate: MaintenanceStep2KMViewModelDelegate?
    var appointment: Case?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getAppoinment() {
        
    }
    
}
