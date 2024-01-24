//
//  LastikOperationsViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation

protocol LastikOperationsVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToRequestNewLastik()
    func goToLastikRandevuConfirmation()
    func goToLastikChange()
    func goToServiceDetail(service: Supplier?, appointment: Case?)
    func goToLastikFromManger()
}

protocol LastikOperationsViewModelDelegate: BaseViewModelDelegate {
    func setTire()
}

protocol LastikOperationsViewModelType: AnyObject {
    var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate? { get set }
    var delegate: LastikOperationsViewModelDelegate? { get set }
    var appointment: Case? { get set }
    var tire: Tire? { get set }
    
    func getBack()
    func goToRequestNewLastik()
    func goToLastikRandevu()
    func goToLastikChange()
    func goToServiceDetail()
    func getTire()
}

class LastikOperationsViewModel: LastikOperationsViewModelType {
    
    weak var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate?
    weak var delegate: LastikOperationsViewModelDelegate?
    
    var appointment: Case?
    var tire: Tire?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestNewLastik() {
        Loading.shared.show()
        APIService.getTireControl { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model {
                for item in model where item.available {
                    self.coordinatorDelegate?.goToLastikFromManger()
                    return
                }
                self.coordinatorDelegate?.goToRequestNewLastik()
            }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
        //
    }
    
    func getTire() {
        Loading.shared.show()
        APIService.getTire { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model, model.count > 0 {
                self.tire = model[0]
                self.delegate?.setTire()
            }
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func goToLastikRandevu() {
        coordinatorDelegate?.goToLastikRandevuConfirmation()
    }
    
    func goToServiceDetail() {
        if let appointment {
            coordinatorDelegate?.goToServiceDetail(service: nil, appointment: appointment)
        }
    }
    
    func goToLastikChange() {
        coordinatorDelegate?.goToLastikChange()
    }
}
