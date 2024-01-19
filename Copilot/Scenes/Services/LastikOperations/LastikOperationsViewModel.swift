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
    func goToLastikRandevu()
    func goToServiceDetail(service: Supplier, randevu: String?)
}

protocol LastikOperationsViewModelDelegate: AnyObject {
    
}

protocol LastikOperationsViewModelType: AnyObject {
    var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate? { get set }
    var delegate: LastikOperationsViewModelDelegate? { get set }
    var appointment: Case? { get set }
    
    func getBack()
    func goToRequestNewLastik()
    func goToLastikRandevu()
    func goToServiceDetail(service: Supplier, randevu: String)
}

class LastikOperationsViewModel: LastikOperationsViewModelType {
    
    weak var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate?
    weak var delegate: LastikOperationsViewModelDelegate?
    
    var appointment: Case?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestNewLastik() {
        coordinatorDelegate?.goToRequestNewLastik()
    }
    
    func goToLastikRandevu() {
        coordinatorDelegate?.goToLastikRandevu()
    }
    
    func goToServiceDetail(service: Supplier, randevu: String) {
        coordinatorDelegate?.goToServiceDetail(service: service, randevu: randevu)
    }
}
