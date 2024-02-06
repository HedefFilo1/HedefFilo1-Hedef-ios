//
//  BrkdwnFlw1Stp2SelectServiceViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation

protocol BrkdwnFlw1Stp2SelectServiceVMCrdintrDlgt: AnyObject {
    func getBack()
    func goToServices(tireSupportType: TireSupportType, towTruck: Bool)
}

protocol BrkdwnFlw1Stp2SelectServiceVMDelegate: AnyObject {
    
}

protocol BrkdwnFlw1Stp2SelectServiceViewModelType: AnyObject {
    var coordinatorDelegate: BrkdwnFlw1Stp2SelectServiceVMCrdintrDlgt? { get set }
    var delegate: BrkdwnFlw1Stp2SelectServiceVMDelegate? { get set }
    
    func getBack()
    func goToServices()
}

class BrkdwnFlw1Stp2SelectServiceViewModel: BrkdwnFlw1Stp2SelectServiceViewModelType {
    
    weak var coordinatorDelegate: BrkdwnFlw1Stp2SelectServiceVMCrdintrDlgt?
    weak var delegate: BrkdwnFlw1Stp2SelectServiceVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices(tireSupportType: .damage, towTruck: true)
    }
}
