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
    func setPrefernces()
}

protocol NotificationSettingsViewModelType: AnyObject {
    var coordinatorDelegate: NotificationSettingsVMCrdinatorDelegate? { get set }
    var delegate: NotificationSettingsViewModelDelegate? { get set }
    var prefrences: [NotificationPreference]? { get set }
    var weatherEnabled: Bool { get }
    var campaignEnabled: Bool { get }
    var appointmentEnabled: Bool { get }
    var agreementEnabled: Bool { get }
    
    func getBack()
    func getPrefrences()
    func setNotificationPreferences(type: NotificationPreferenceType, enabled: Bool)
}

class NotificationSettingsViewModel: NotificationSettingsViewModelType {
    
    weak var coordinatorDelegate: NotificationSettingsVMCrdinatorDelegate?
    weak var delegate: NotificationSettingsViewModelDelegate?
    
    var prefrences: [NotificationPreference]?
   
    var weatherEnabled: Bool {
        if let item = prefrences?.filter({ $0.type == .weather }).first {
            return item.enabled
        }
        
        return false
    }
    
    var campaignEnabled: Bool {
        if let item = prefrences?.filter({ $0.type == .campaign }).first {
            return item.enabled
        }
        
        return false
    }
    
    var appointmentEnabled: Bool {
        if let item = prefrences?.filter({ $0.type == .campaign }).first {
            return item.enabled
        }
        
        return false
    }
    
    var agreementEnabled: Bool {
        if let item = prefrences?.filter({ $0.type == .agreement }).first {
            return item.enabled
        }
        
        return false
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getPrefrences() {
        
        Loading.shared.show()
        APIService.getNotificationPreferences { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if let model {
                self.prefrences = model
                self.delegate?.setPrefernces()
            }
        }
    }
    
    func setNotificationPreferences(type: NotificationPreferenceType, enabled: Bool) {
        Loading.shared.show()
        APIService.setNotificationPreferences(type: type, enabled: enabled) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
}
