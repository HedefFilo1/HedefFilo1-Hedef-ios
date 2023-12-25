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
}

protocol LastikOperationsViewModelDelegate: AnyObject {
    
}

protocol LastikOperationsViewModelType: AnyObject {
    var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate? { get set }
    var delegate: LastikOperationsViewModelDelegate? { get set }
    
    func getBack()
    func goToRequestNewLastik()
}

class LastikOperationsViewModel: LastikOperationsViewModelType {
    
    weak var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate?
    weak var delegate: LastikOperationsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestNewLastik() {
        coordinatorDelegate?.goToRequestNewLastik()
    }
}
