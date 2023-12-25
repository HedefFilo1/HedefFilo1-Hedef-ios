//
//  NewLastikRequestViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol NewLastikRequestVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol NewLastikRequestViewModelDelegate: AnyObject {
    
}

protocol NewLastikRequestViewModelType: AnyObject {
    var coordinatorDelegate: NewLastikRequestVMCoordinatorDelegate? { get set }
    var delegate: NewLastikRequestViewModelDelegate? { get set }
    
    func getBack()
}

class NewLastikRequestViewModel: NewLastikRequestViewModelType {
    
    weak var coordinatorDelegate: NewLastikRequestVMCoordinatorDelegate?
    weak var delegate: NewLastikRequestViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
