//
//  SettingsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/11/24.
//

import Foundation
protocol SettingsViewModelCoordinatorDelegate: AnyObject {
    func getBack()
    func goToNotificationSettings()
    func goToAgreement()
    func presentLangauges()
}

protocol SettingsViewModelDelegate: BaseViewModelDelegate {
    
}

protocol SettingsViewModelType: AnyObject {
    var coordinatorDelegate: SettingsViewModelCoordinatorDelegate? { get set }
    var delegate: SettingsViewModelDelegate? { get set }
    func getBack()
    func goToNotificationSettings()
    func goToAgreement()
    func presentLangauges()
}

class SettingsViewModel: SettingsViewModelType {
    
    weak var coordinatorDelegate: SettingsViewModelCoordinatorDelegate?
    weak var delegate: SettingsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToNotificationSettings() {
        coordinatorDelegate?.goToNotificationSettings()
    }
    
    func goToAgreement() {
        coordinatorDelegate?.goToAgreement()
    }
    
    func presentLangauges() {
        coordinatorDelegate?.presentLangauges()
    }
}
