//
//  BrkdwnFlw2Stp4SelectedWarningsViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import Foundation

protocol BrkdnFlw2Stp4SelectedWrnngsVMCrdntrDlgt: AnyObject {
    func getBack()
    func goToWarningLights(delegate: WarningLightsViewControllerDelegate, warnings: [MockWarning])
    func goToServices(towTruck: Bool)
    
}

protocol BrkdwnFlw2Stp4SelectedWarningsVMDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol BrkdwnFlw2Stp4SelectedWarningsVMType: AnyObject {
    var coordinatorDelegate: BrkdnFlw2Stp4SelectedWrnngsVMCrdntrDlgt? { get set }
    var delegate: BrkdwnFlw2Stp4SelectedWarningsVMDelegate? { get set }
    var warnings: [MockWarning]? { get }
    var isJustYellowWarning: Bool { get }
    func goToWarningLights()
    func goToServices()
    func getBack()
    
}

class BrkdwnFlw2Stp4SelectedWarningsViewModel: BrkdwnFlw2Stp4SelectedWarningsVMType {
    
    weak var coordinatorDelegate: BrkdnFlw2Stp4SelectedWrnngsVMCrdntrDlgt?
    weak var delegate: BrkdwnFlw2Stp4SelectedWarningsVMDelegate?
    
    var allWarninggs: [MockWarning] = []
    var warnings: [MockWarning]? {
        return allWarninggs.filter({ $0.selected })
    }
    
    // FLow 3 here
    var isJustYellowWarning: Bool {
        if let warnings {
            for item in warnings where item.isRed {
                return false
            }
        }
        return true
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToWarningLights() {
        coordinatorDelegate?.goToWarningLights(delegate: self, warnings: allWarninggs)
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices(towTruck: false)
    }
}

extension BrkdwnFlw2Stp4SelectedWarningsViewModel: WarningLightsViewControllerDelegate {
    
    func didSelect(item: MockWarning) {
        item.selected = true
        delegate?.reloadData()
    }
    
}
