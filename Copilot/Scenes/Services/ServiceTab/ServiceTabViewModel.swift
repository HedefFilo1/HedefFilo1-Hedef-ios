//
//  ServiceTabViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation

protocol ServiceTabViewModelCoordinatorDelegate: AnyObject {
    func goToLastikOperations(appointment: Case?)
    func goToMiantenance(appointment: Case?)
}

protocol ServiceTabViewModelDelegate: BaseViewModelDelegate {
    func setAppointment()
}

protocol ServiceTabViewModelType: AnyObject {
    var coordinatorDelegate: ServiceTabViewModelCoordinatorDelegate? { get set }
    var delegate: ServiceTabViewModelDelegate? { get set }
    var appointment: Case? { get set }
    var maintenanceAppointment: Case? { get set }
    func goToLastikOperations()
    func getAppointment()
    func goToMaintenance()
}

class ServiceTabViewModel: ServiceTabViewModelType {
    
    weak var coordinatorDelegate: ServiceTabViewModelCoordinatorDelegate?
    weak var delegate: ServiceTabViewModelDelegate?
    
    var appointment: Case?
    var maintenanceAppointment: Case?
    
    func goToLastikOperations() {
        coordinatorDelegate?.goToLastikOperations(appointment: appointment)
    }
    
    func goToMaintenance() {
        coordinatorDelegate?.goToMiantenance(appointment: maintenanceAppointment)
    }
    
    func getAppointment() {
        Loading.shared.show()
        APIService.getCase { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model, model.count > 0 {
                self.appointment = model[0]
                self.delegate?.setAppointment()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
}
