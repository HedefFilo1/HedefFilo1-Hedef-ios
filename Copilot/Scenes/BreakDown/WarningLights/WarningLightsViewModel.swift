//
//  WarningLightsViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import Foundation

protocol WarningLightsViewModelVMCrdntrDlgt: AnyObject {
    func getBack()
    func goToBrkdwnFlw2Stp4SelectedWarnings()
}

protocol WarningLightsViewModelVMDelegate: BaseViewModelDelegate {
    
}

protocol WarningLightsViewModelType: AnyObject {
    var coordinatorDelegate: WarningLightsViewModelVMCrdntrDlgt? { get set }
    var delegate: WarningLightsViewModelVMDelegate? { get set }

    func getBack()
    func goToBrkdwnFlw2Stp4SelectedWarnings()
}

class WarningLightsViewModel: WarningLightsViewModelType {
    
    weak var coordinatorDelegate: WarningLightsViewModelVMCrdntrDlgt?
    weak var delegate: WarningLightsViewModelVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToBrkdwnFlw2Stp4SelectedWarnings() {
        coordinatorDelegate?.goToBrkdwnFlw2Stp4SelectedWarnings()
    }
}
