//
//  Flow1Step4ResultViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol Flow1Step4ResultVMCoordinatorDelegate: AnyObject {
    func getBack()
    func getBackToHome()
    func goToRequests()
}

protocol Flow1Step4ResultViewModelDelegate: AnyObject {
    
}

protocol Flow1Step4ResultViewModelType: AnyObject {
    var coordinatorDelegate: Flow1Step4ResultVMCoordinatorDelegate? { get set }
    var delegate: Flow1Step4ResultViewModelDelegate? { get set }
    
    func getBack()
    func getBackToHome()
    func goToRequests()
}

class Flow1Step4ResultViewModel: Flow1Step4ResultViewModelType {
    
    weak var coordinatorDelegate: Flow1Step4ResultVMCoordinatorDelegate?
    weak var delegate: Flow1Step4ResultViewModelDelegate?
    
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
