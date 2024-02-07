//
//  BrkdwnFlw2Stp3WarningLightsViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation
protocol BrkdwnFlw2Stp3WarningLightsVMCrdntrDlgt: AnyObject {
    func getBack()
    
}

protocol BrkdwnFlw2Stp3WarningLightsVMDelegate: BaseViewModelDelegate {
    func setBrkdwnFlw2Stp3WarningLights()
}

protocol BrkdwnFlw2Stp3WarningLightsViewModelType: AnyObject {
    var coordinatorDelegate: BrkdwnFlw2Stp3WarningLightsVMCrdntrDlgt? { get set }
    var delegate: BrkdwnFlw2Stp3WarningLightsVMDelegate? { get set }
    var appointment: Case? { get set }
    func getBack()
    
}

class BrkdwnFlw2Stp3WarningLightsViewModel: BrkdwnFlw2Stp3WarningLightsViewModelType {
    
    weak var coordinatorDelegate: BrkdwnFlw2Stp3WarningLightsVMCrdntrDlgt?
    weak var delegate: BrkdwnFlw2Stp3WarningLightsVMDelegate?
    var appointment: Case?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
