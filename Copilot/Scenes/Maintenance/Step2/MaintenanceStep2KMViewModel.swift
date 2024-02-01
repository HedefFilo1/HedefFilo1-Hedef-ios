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
    func goToServices()
}

protocol MaintenanceStep2KMViewModelDelegate: BaseViewModelDelegate {
}

protocol MaintenanceStep2KMViewModelType: AnyObject {
    var coordinatorDelegate: MaintenanceStep2KMVMCoordinatorDelegate? { get set }
    var delegate: MaintenanceStep2KMViewModelDelegate? { get set }
    
    func getBack()
    func goToNotMaintenancePeriod()
    func checkEligible()
}

class MaintenanceStep2KMViewModel: MaintenanceStep2KMViewModelType {
    
    weak var coordinatorDelegate: MaintenanceStep2KMVMCoordinatorDelegate?
    weak var delegate: MaintenanceStep2KMViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToNotMaintenancePeriod() {
        coordinatorDelegate?.goToServices()
//        coordinatorDelegate?.goToNotMaintenancePeriod()
    }
    
    func checkEligible() {
        Loading.shared.show()
        APIService.getMaintenanceEligible { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if model != nil {
                self.coordinatorDelegate?.goToServices()
            } else {
                self.goToNotMaintenancePeriod()
            }
//            if let error = error {
//                self.delegate?.showError(title: Strings.errorTitle,
//                                         message: error.message)
//            }
        }
    }
    
}
