//
//  NewLastikRequestViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol NewLastikRequestVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToLastikFromManger()
}

protocol NewLastikRequestViewModelDelegate: AnyObject {
    
}

protocol NewLastikRequestViewModelType: AnyObject {
    var coordinatorDelegate: NewLastikRequestVMCoordinatorDelegate? { get set }
    var delegate: NewLastikRequestViewModelDelegate? { get set }
    
    func getBack()
    func lastikFromManger()
}

class NewLastikRequestViewModel: NewLastikRequestViewModelType {
    
    weak var coordinatorDelegate: NewLastikRequestVMCoordinatorDelegate?
    weak var delegate: NewLastikRequestViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func lastikFromManger() {
        coordinatorDelegate?.goToLastikFromManger()
    }
}
