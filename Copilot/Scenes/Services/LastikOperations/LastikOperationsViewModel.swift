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
    func goToServiceDetail(appointment: Case)
    func goToLastikFromManger()
}

protocol LastikOperationsViewModelDelegate: BaseViewModelDelegate {
    
}

protocol LastikOperationsViewModelType: AnyObject {
    var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate? { get set }
    var delegate: LastikOperationsViewModelDelegate? { get set }
    var appointment: Case? { get set }
    
    func getBack()
    func goToRequestNewLastik()
    func goToLastikRandevu()
    func goToLastikChange()
    func goToServiceDetail()
}

class LastikOperationsViewModel: LastikOperationsViewModelType {
    
    weak var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate?
    weak var delegate: LastikOperationsViewModelDelegate?
    
    var appointment: Case?
    
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
    
    func goToLastikRandevu() {
        coordinatorDelegate?.goToLastikRandevuConfirmation()
    }
    
    func goToServiceDetail() {
        if let appointment {
            coordinatorDelegate?.goToServiceDetail(appointment: appointment)
        }
    }
    
    func goToLastikChange() {
        coordinatorDelegate?.goToLastikChange()
    }
}
