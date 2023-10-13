//
//  ProfileViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/13/23.
//

import Foundation

protocol ProfileViewModelCoordinatorDelegate: AnyObject {
    func goToResetPassword()
}

protocol ProfileViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
    func showSuccess(title: String, message: String)
}

protocol ProfileViewModelType: AnyObject {
    var delegate: ProfileViewModelDelegate? { get set }
    func goToResetPassword()
    func submit(name: String, phone: String, email: String, id: String, licence: String)
}

class ProfileViewModel: ProfileViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: ProfileViewModelCoordinatorDelegate?
    weak var delegate: ProfileViewModelDelegate?

    func submit(name: String, phone: String, email: String, id: String, licence: String) {
        delegate?.showSuccess(title: "Successful", message: "Your profile updated.")
    }
    
    func goToResetPassword() {
        coordinatorDelegate?.goToResetPassword()
    }
}
