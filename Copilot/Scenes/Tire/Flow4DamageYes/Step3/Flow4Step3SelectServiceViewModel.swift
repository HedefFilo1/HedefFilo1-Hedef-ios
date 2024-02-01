//
//  Flow4Step3SelectServiceViewController.swift
//  Copilot
//
//  Created by Jamal on 12/26/23.
//

import Foundation

protocol Flow4Step3SelectServiceVMCoordinatorDlgt: AnyObject {
    func getBack()
    func goToServices(tireSupportType: TireSupportType, towTruck: Bool)
}

protocol Flow4Step3SelectServiceViewModelDelegate: AnyObject {
    
}

protocol Flow4Step3SelectServiceViewModelType: AnyObject {
    var coordinatorDelegate: Flow4Step3SelectServiceVMCoordinatorDlgt? { get set }
    var delegate: Flow4Step3SelectServiceViewModelDelegate? { get set }
    var tireSupportType: TireSupportType? { get set }
    func getBack()
    func goToServices()
}

class Flow4Step3SelectServiceViewModel: Flow4Step3SelectServiceViewModelType {
    
    weak var coordinatorDelegate: Flow4Step3SelectServiceVMCoordinatorDlgt?
    weak var delegate: Flow4Step3SelectServiceViewModelDelegate?
    
    var tireSupportType: TireSupportType? = .damage
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices(tireSupportType: tireSupportType ?? .damage, towTruck: false)
    }
}
