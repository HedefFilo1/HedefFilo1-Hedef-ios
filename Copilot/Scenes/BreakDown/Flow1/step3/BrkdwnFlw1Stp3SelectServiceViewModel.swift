//
//  BrkdwnFlw1Stp3SelectServiceViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation

protocol BrkdwnFlw1Stp3SelectServiceVMCrdintrDlgt: AnyObject {
    func getBack()
    func goToServices()
}

protocol BrkdwnFlw1Stp3SelectServiceVMDelegate: AnyObject {
    
}

protocol BrkdwnFlw1Stp3SelectServiceViewModelType: AnyObject {
    var coordinatorDelegate: BrkdwnFlw1Stp3SelectServiceVMCrdintrDlgt? { get set }
    var delegate: BrkdwnFlw1Stp3SelectServiceVMDelegate? { get set }
    
    func getBack()
    func goToServices()
}

class BrkdwnFlw1Stp3SelectServiceViewModel: BrkdwnFlw1Stp3SelectServiceViewModelType {
    
    weak var coordinatorDelegate: BrkdwnFlw1Stp3SelectServiceVMCrdintrDlgt?
    weak var delegate: BrkdwnFlw1Stp3SelectServiceVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices()
    }
}
