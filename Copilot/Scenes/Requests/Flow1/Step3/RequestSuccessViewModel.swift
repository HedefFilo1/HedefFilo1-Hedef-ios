//
//  RequestSuccessViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

protocol RequestSuccessVMCoordinatorDelegate: AnyObject {
    func getBack()
    func getBackToHome()
    func goToRequests()
}

protocol RequestSuccessViewModelDelegate: AnyObject {
    
}

protocol RequestSuccessViewModelType: AnyObject {
    var coordinatorDelegate: RequestSuccessVMCoordinatorDelegate? { get set }
    var delegate: RequestSuccessViewModelDelegate? { get set }
    func getBack()
    func getBackToHome()
    func goToRequests()
}

class RequestSuccessViewModel: RequestSuccessViewModelType {

    weak var coordinatorDelegate: RequestSuccessVMCoordinatorDelegate?
    weak var delegate: RequestSuccessViewModelDelegate?
    
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
