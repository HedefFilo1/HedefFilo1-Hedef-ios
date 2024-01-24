//
//  ServiceRandevuViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/3/24.
//

import Foundation

protocol ServiceRandevuVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToConfirmedRandevu(service: Supplier, date: Date)
}

protocol ServiceRandevuViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ServiceRandevuViewModelType: AnyObject {
    var coordinatorDelegate: ServiceRandevuVMCoordinatorDelegate? { get set }
    var delegate: ServiceRandevuViewModelDelegate? { get set }
    var service: Supplier? { get set }
    var date: Date? { get set }
    var displayDate: String? { get }
    func getBack()
    func goToConfirmedRandevu()
    func createRandevu()
}

class ServiceRandevuViewModel: ServiceRandevuViewModelType {
    weak var coordinatorDelegate: ServiceRandevuVMCoordinatorDelegate?
    weak var delegate: ServiceRandevuViewModelDelegate?
    
    var service: Supplier?
    var date: Date?
    
    var displayDate: String? {
        guard let date = date else { return nil }
        let formmater = DateFormatter()
        formmater.dateFormat = "d MMMM YYYY EEEE HH:mm"
        formmater.locale = Locale(identifier: "tr_TR")
        return formmater.string(from: date)
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToConfirmedRandevu() {
        if let service, let date {
            coordinatorDelegate?.goToConfirmedRandevu(service: service, date: date)
        }
    }
    
    func createRandevu() {
        guard let service, let date else { return }
        Loading.shared.show()
        APIService.createCase(tireType: .damege,
                              towTruck: false,
                              supplierName: service.name,
                              supplierPhone: "",
                              city: service.city ?? "",
                              district: service.district ?? "",
                              appointmentDate: date) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                self.goToConfirmedRandevu()
            }
        }
    }
}
