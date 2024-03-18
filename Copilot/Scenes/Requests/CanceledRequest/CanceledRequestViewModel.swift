//
//  CanceledRequestViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import Foundation

protocol CanceledRequestVMCoordinatorDelegate: AnyObject {
    func getBack()
    func getBackToHome()
    func goToRequests()
}

protocol CanceledRequestViewModelDelegate: AnyObject {
    
}

protocol CanceledRequestViewModelType: AnyObject {
    var coordinatorDelegate: CanceledRequestVMCoordinatorDelegate? { get set }
    var delegate: CanceledRequestViewModelDelegate? { get set }
    var title: String { get set }
    func getBack()
    func getBackToHome()
    func goToRequests()
}

class CanceledRequestViewModel: CanceledRequestViewModelType {

    weak var coordinatorDelegate: CanceledRequestVMCoordinatorDelegate?
    weak var delegate: CanceledRequestViewModelDelegate?
    
    var title: String = ""
    
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
