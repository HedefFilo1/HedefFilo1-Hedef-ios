//
//  BrkdwnFlw4Stp3NoWarningViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import Foundation

protocol BrkdwnFlw4Stp3NoWarningVMCrdntrDlgt: AnyObject {
    func getBack()
    func goToServices(towTruck: Bool)
    func getBackToHome()
    func goToWarningGuide()
}

protocol BrkdwnFlw4Stp3NoWarningVMDelegate: BaseViewModelDelegate {
    
}

protocol BrkdwnFlw4Stp3NoWarningViewModelType: AnyObject {
    var coordinatorDelegate: BrkdwnFlw4Stp3NoWarningVMCrdntrDlgt? { get set }
    var delegate: BrkdwnFlw4Stp3NoWarningVMDelegate? { get set }

    func goToServices()
    func getBack()
    func getBackToHome()
    func goToWarningGuide()
}

class BrkdwnFlw4Stp3NoWarningViewModel: BrkdwnFlw4Stp3NoWarningViewModelType {
    
    weak var coordinatorDelegate: BrkdwnFlw4Stp3NoWarningVMCrdntrDlgt?
    weak var delegate: BrkdwnFlw4Stp3NoWarningVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices(towTruck: false)
    }
    
    func getBackToHome() {
        coordinatorDelegate?.getBackToHome()
    }
    
    func goToWarningGuide() {
        coordinatorDelegate?.goToWarningGuide()
    }
}
