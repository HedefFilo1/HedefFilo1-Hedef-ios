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
    func goToBreakDown(appointment: Case?)
}

protocol ServiceTabViewModelDelegate: BaseViewModelDelegate {
    func setTireAppointment()
    func setMaintenanceAppointment()
    func setBreakdownAppointment()
}

protocol ServiceTabViewModelType: AnyObject {
    var coordinatorDelegate: ServiceTabViewModelCoordinatorDelegate? { get set }
    var delegate: ServiceTabViewModelDelegate? { get set }
    var tireAppointment: Case? { get set }
    var maintenanceAppointment: Case? { get set }
    var breakdownAppointment: Case? { get set }
    func goToLastikOperations()
    func getAppointments()
    func goToMaintenance()
    func goToBreakDown()
}

class ServiceTabViewModel: ServiceTabViewModelType {
    
    weak var coordinatorDelegate: ServiceTabViewModelCoordinatorDelegate?
    weak var delegate: ServiceTabViewModelDelegate?
    
    var tireAppointment: Case?
    var maintenanceAppointment: Case?
    var breakdownAppointment: Case?
    
    func goToLastikOperations() {
        coordinatorDelegate?.goToLastikOperations(appointment: tireAppointment)
    }
    
    func goToMaintenance() {
        coordinatorDelegate?.goToMiantenance(appointment: maintenanceAppointment)
    }
    
    func goToBreakDown() {
        coordinatorDelegate?.goToBreakDown(appointment: breakdownAppointment)
    }
    
    func getAppointments() {
        Loading.shared.show()
        APIService.getCase { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model, model.count > 0 {
                
                for item in model {
                    if item.recordType == .tireChange || item.recordType == .damage,
                        item.appointmentDate != nil {
                        self.tireAppointment = item
                        self.delegate?.setTireAppointment()
                        
                    } else if item.recordType == .maintenance,
                              item.appointmentDate != nil {
                        self.maintenanceAppointment = item
                        self.delegate?.setMaintenanceAppointment()
                        
                    } else if item.recordType == .mechanicalFailure,
                              item.appointmentDate != nil {
                        self.breakdownAppointment = item
                        self.delegate?.setBreakdownAppointment()
                    } 
                }
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
}
