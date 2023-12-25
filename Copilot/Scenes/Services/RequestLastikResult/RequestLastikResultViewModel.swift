//
//  RequestLastikResultViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol RequestLastikResultVMCoordinatorDelegate: AnyObject {
    func getBack()
    func getBackToHome()
    func goToRequests()
}

protocol RequestLastikResultViewModelDelegate: AnyObject {
    
}

protocol RequestLastikResultViewModelType: AnyObject {
    var coordinatorDelegate: RequestLastikResultVMCoordinatorDelegate? { get set }
    var delegate: RequestLastikResultViewModelDelegate? { get set }
    
    func getBack()
    func getBackToHome()
    func goToRequests()
}

class RequestLastikResultViewModel: RequestLastikResultViewModelType {
    
    weak var coordinatorDelegate: RequestLastikResultVMCoordinatorDelegate?
    weak var delegate: RequestLastikResultViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getBackToHome() {
        coordinatorDelegate?.getBackToHome()
    }
    
    func goToRequests() {
        coordinatorDelegate?.goToRequests()
    }
}
