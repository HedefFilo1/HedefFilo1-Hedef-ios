//
//  ProfileViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/13/23.
//

import Foundation

protocol ProfileViewModelCoordinatorDelegate: AnyObject {
    func goToResetPassword()
    func presentDeleteAccount()
}

protocol ProfileViewModelDelegate: AnyObject {
    func setProfile()
    func showError(title: String, message: String)
    func showSuccess(title: String, message: String)
}

protocol ProfileViewModelType: AnyObject {
    var delegate: ProfileViewModelDelegate? { get set }
    var coordinatorDelegate: ProfileViewModelCoordinatorDelegate? { get set }
    var profile: GetProfile? { get set}
    func getProfile()
    func goToResetPassword()
    func submit(name: String, phone: String, email: String, id: String, licence: String)
    func presentDeleteAccount()
}

class ProfileViewModel: ProfileViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: ProfileViewModelCoordinatorDelegate?
    weak var delegate: ProfileViewModelDelegate?
    var profile: GetProfile?
    
    func getProfile() {
        Loading.shared.show()
        APIService.getProfile { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let profile = model {
                self.profile = profile
                self.delegate?.setProfile()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
        }
    }
    
    func submit(name: String, phone: String, email: String, id: String, licence: String) {
        let text = App.getString(key: "copilotapp.profile.success.update") ?? ""
        delegate?.showSuccess(title: "", message: text)
    }
    
    func goToResetPassword() {
        coordinatorDelegate?.goToResetPassword()
    }
    
    func presentDeleteAccount() {
        coordinatorDelegate?.presentDeleteAccount()
    }
}
