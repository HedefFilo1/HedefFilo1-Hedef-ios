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
    func goToLastikChange()
    func goToServiceDetail(appointment: Case)
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
        coordinatorDelegate?.goToRequestNewLastik()
    }
    
    func goToLastikRandevu() {
        coordinatorDelegate?.goToLastikRandevu()
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
