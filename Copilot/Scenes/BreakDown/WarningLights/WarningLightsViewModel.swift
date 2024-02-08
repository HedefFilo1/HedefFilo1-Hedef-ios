//
//  WarningLightsViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import Foundation

protocol WarningLightsViewModelVMCrdntrDlgt: AnyObject {
    func getBack()
}

protocol WarningLightsViewModelVMDelegate: BaseViewModelDelegate {
    
}

protocol WarningLightsViewModelType: AnyObject {
    var coordinatorDelegate: WarningLightsViewModelVMCrdntrDlgt? { get set }
    var delegate: WarningLightsViewModelVMDelegate? { get set }
    var warnings: [MockWarning] { get set }
    func getBack()
}

class WarningLightsViewModel: WarningLightsViewModelType {
    
    weak var coordinatorDelegate: WarningLightsViewModelVMCrdntrDlgt?
    weak var delegate: WarningLightsViewModelVMDelegate?
    var warnings: [MockWarning] = allWarnings
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
