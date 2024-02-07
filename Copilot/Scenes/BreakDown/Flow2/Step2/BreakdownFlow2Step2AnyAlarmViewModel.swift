//
//  BrkdwnFlw2Stp2AnyAlarmViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation

protocol BrkdwnFlw2Stp2AnyAlarmVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToBrkdwnFlw1Stp3SelectService()
}

protocol BrkdwnFlw2Stp2AnyAlarmViewModelDelegate: BaseViewModelDelegate {
    
}

protocol BrkdwnFlw2Stp2AnyAlarmViewModelType: AnyObject {
    var coordinatorDelegate: BrkdwnFlw2Stp2AnyAlarmVMCrdinatorDlgt? { get set }
    var delegate: BrkdwnFlw2Stp2AnyAlarmViewModelDelegate? { get set }
    func getBack()
    func goToBrkdwnFlw1Stp3SelectService()
}

class BrkdwnFlw2Stp2AnyAlarmViewModel: BrkdwnFlw2Stp2AnyAlarmViewModelType {
    
    weak var coordinatorDelegate: BrkdwnFlw2Stp2AnyAlarmVMCrdinatorDlgt?
    weak var delegate: BrkdwnFlw2Stp2AnyAlarmViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToBrkdwnFlw1Stp3SelectService() {
        coordinatorDelegate?.goToBrkdwnFlw1Stp3SelectService()
    }
    
}
