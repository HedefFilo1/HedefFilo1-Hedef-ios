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
    func goToPastServices(tab: PastServiceRecordType)
}

protocol Flow1Step4ResultViewModelDelegate: AnyObject {
    
}

protocol Flow1Step4ResultViewModelType: AnyObject {
    var coordinatorDelegate: Flow1Step4ResultVMCoordinatorDelegate? { get set }
    var delegate: Flow1Step4ResultViewModelDelegate? { get set }
    var tireType: TireControlType { get set }
    func getBack()
    func getBackToHome()
    func goToRequests()
    func goToPastServices()
}

class Flow1Step4ResultViewModel: Flow1Step4ResultViewModelType {
    
    weak var coordinatorDelegate: Flow1Step4ResultVMCoordinatorDelegate?
    weak var delegate: Flow1Step4ResultViewModelDelegate?
    
    var tireType: TireControlType = .summer
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getBackToHome() {
        coordinatorDelegate?.getBackToHome()
    }
    
    func goToRequests() {
        coordinatorDelegate?.goToRequests()
    }
    
    func goToPastServices() {
        coordinatorDelegate?.goToPastServices(tab: .tireChange)
    }
}
