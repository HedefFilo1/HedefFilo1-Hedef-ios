//
//  ServiceRandevuViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/3/24.
//

import Foundation

protocol ServiceRandevuVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToConfirmedRandevu(service: Supplier?, date: Date?, appointment: Case?, tireSupportType: TireSupportType?)
}

protocol ServiceRandevuViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ServiceRandevuViewModelType: AnyObject {
    var coordinatorDelegate: ServiceRandevuVMCoordinatorDelegate? { get set }
    var delegate: ServiceRandevuViewModelDelegate? { get set }
    var service: Supplier? { get set }
    var appointment: Case? { get set }
    var towTruck: Bool { get set }
    var date: Date? { get set }
    var displayDate: String? { get }
    var tireSupportType: TireSupportType? { get set }
    func getBack()
    func goToConfirmedRandevu()
    func createRandevu()
    func updateRandevu()
}

class ServiceRandevuViewModel: ServiceRandevuViewModelType {
    weak var coordinatorDelegate: ServiceRandevuVMCoordinatorDelegate?
    weak var delegate: ServiceRandevuViewModelDelegate?
    
    var service: Supplier?
    var date: Date?
    var tireSupportType: TireSupportType? = .damage
    var towTruck = false
    var appointment: Case?
    
    var displayDate: String? {
        guard let date = date else { return nil }
        let formmater = DateFormatter()
        formmater.dateFormat = "d MMMM YYYY EEEE HH:mm"
        var identifier = "tr_TR"
        let language = App.language
        if language == CodeStrings.english {
            identifier = "UTC"
        }
        formmater.locale = Locale(identifier: identifier)
        return formmater.string(from: date)
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToConfirmedRandevu() {
        if let service {
            coordinatorDelegate?.goToConfirmedRandevu(service: service, date: date, appointment: nil, tireSupportType: tireSupportType)
        }
    }
    
    func createRandevu() {
        #if DEV_DEBUG
        self.goToConfirmedRandevu()
        #endif
        guard let service else { return }
        Loading.shared.show()
        APIService.createCase(supplierId: service.id,
                              tireType: tireSupportType ?? .damage,
                              towTruck: towTruck,
                              supplierName: service.name,
                              supplierPhone: service.phone ?? "",
                              city: service.city ?? "",
                              district: service.district ?? "",
                              appointmentDate: date) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                APIService.addUserAction(pageName: "CASE", actionName: "CASE_UPSERT")
                if towTruck {
                    APIService.addUserAction(pageName: "Services", actionName: "SERVICE_TIRE_MAKE_TIRE_APPOINTMENT_TOWING_TRUCK_REQUEST")
                }
                if tireSupportType == .damage {
                    APIService.addUserAction(pageName: "Services", actionName: "SERVICE_TIRE_CONFIRM_TIRE_DAMAGE_APPOINTMENT")
                }
                
                if tireSupportType == .change {
                    APIService.addUserAction(pageName: "Services", actionName: "SERVICE_TIRE_MAKE_TIRE_REPLACEMENT_APPOINTMENT")
                }
                
                self.goToConfirmedRandevu()
            }
        }
    }
    
    func updateRandevu() {
        guard let appointment, let date else { return }
        
        #if DEV_DEBUG
        self.coordinatorDelegate?.goToConfirmedRandevu(service: nil, date: date, appointment: appointment, tireSupportType: tireSupportType)
        #endif
        
        Loading.shared.show()
        APIService.updateCase(caseId: appointment.id ?? "",
                              appointmentDate: date) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                if self is MaintenanceRandevuViewModel {
                    APIService.addUserAction(pageName: "Services", actionName: "SERVICE_MAINTENANCE_SCHEDULE_MAINTENANCE_APPOINTMENT")
                }
                
                if tireSupportType == .damage {
                    APIService.addUserAction(pageName: "Services", actionName: "SERVICE_TIRE_SCHEDULE_TIRE_DAMAGE_APPOINTMENT")
                }
                
                if tireSupportType == .change {
                    APIService.addUserAction(pageName: "Services", actionName: "SERVICE_TIRE_MAKE_TIRE_REPLACEMENT_APPOINTMENT")
                }
                
                self.coordinatorDelegate?.goToConfirmedRandevu(service: nil, date: date, appointment: appointment, tireSupportType: tireSupportType)
            }
        }
    }
}
