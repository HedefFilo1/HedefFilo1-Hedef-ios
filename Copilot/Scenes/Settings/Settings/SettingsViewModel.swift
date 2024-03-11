//
//  SettingsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/11/24.
//

import Foundation
protocol SettingsViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol SettingsViewModelDelegate: BaseViewModelDelegate {
    
}

protocol SettingsViewModelType: AnyObject {
    var coordinatorDelegate: SettingsViewModelCoordinatorDelegate? { get set }
    var delegate: SettingsViewModelDelegate? { get set }
    func getBack()
}

class SettingsViewModel: SettingsViewModelType {
    
    weak var coordinatorDelegate: SettingsViewModelCoordinatorDelegate?
    weak var delegate: SettingsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
