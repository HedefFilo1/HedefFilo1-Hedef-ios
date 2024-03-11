//
//  NotificationNotificationSettingsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/11/24.
//

import Foundation

protocol NotificationSettingsVMCrdinatorDelegate: AnyObject {
    func getBack()
}

protocol NotificationSettingsViewModelDelegate: BaseViewModelDelegate {
    
}

protocol NotificationSettingsViewModelType: AnyObject {
    var coordinatorDelegate: NotificationSettingsVMCrdinatorDelegate? { get set }
    var delegate: NotificationSettingsViewModelDelegate? { get set }
    func getBack()
}

class NotificationSettingsViewModel: NotificationSettingsViewModelType {
    
    weak var coordinatorDelegate: NotificationSettingsVMCrdinatorDelegate?
    weak var delegate: NotificationSettingsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    
}
