//
//  MaintenanceStep2KMStep2KMViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/30/24.
//

import Foundation
protocol MaintenanceStep2KMVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToNotMaintenancePeriod(nextMaintenanceKm: Int, userInputKm: Int)
    func goToServices()
}

protocol MaintenanceStep2KMViewModelDelegate: BaseViewModelDelegate {
}

protocol MaintenanceStep2KMViewModelType: AnyObject {
    var coordinatorDelegate: MaintenanceStep2KMVMCoordinatorDelegate? { get set }
    var delegate: MaintenanceStep2KMViewModelDelegate? { get set }
    
    func getBack()
    func goToNotMaintenancePeriod(nextMaintenanceKm: Int, userInputKm: Int)
    func checkEligible(kmeter: Int)
}

class MaintenanceStep2KMViewModel: MaintenanceStep2KMViewModelType {
    
    weak var coordinatorDelegate: MaintenanceStep2KMVMCoordinatorDelegate?
    weak var delegate: MaintenanceStep2KMViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToNotMaintenancePeriod(nextMaintenanceKm: Int, userInputKm: Int) {
        coordinatorDelegate?.goToNotMaintenancePeriod(nextMaintenanceKm: nextMaintenanceKm, userInputKm: userInputKm)
    }
    
    func checkEligible(kmeter: Int) {
        Loading.shared.show()
        APIService.getMaintenanceEligible(kmeter: kmeter) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model {
                if model.eligible {
                    self.coordinatorDelegate?.goToServices()
                } else {
                    self.goToNotMaintenancePeriod(nextMaintenanceKm: model.nextMaintenanceKm, userInputKm: kmeter)
                }
            }
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
}
