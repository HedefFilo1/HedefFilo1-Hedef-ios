//
//  LastikOperationsViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation

protocol LastikOperationsVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol LastikOperationsViewModelDelegate: AnyObject {
    
}

protocol LastikOperationsViewModelType: AnyObject {
    var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate? { get set }
    var delegate: LastikOperationsViewModelDelegate? { get set }
    
    func getBack()
}

class LastikOperationsViewModel: LastikOperationsViewModelType {
    
    var coordinatorDelegate: LastikOperationsVMCoordinatorDelegate?
    weak var delegate: LastikOperationsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
