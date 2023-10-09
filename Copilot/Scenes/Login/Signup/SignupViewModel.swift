//
//  SignupViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/5/23.
//

import Foundation

protocol SignupViewModelCoordinatorDelegate: AnyObject {
    func goToLogin()
}

protocol SignupViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
    func showSuccess(title: String, message: String)
}

protocol SignupViewModelType: AnyObject {
    var delegate: SignupViewModelDelegate? { get set }
    func goToLogin()
    func signup(name: String, phone: String, email: String, id: String, licence: String, password: String)
}

class SignupViewModel: SignupViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: SignupViewModelCoordinatorDelegate?
    weak var delegate: SignupViewModelDelegate?
    
    func goToLogin() {
        coordinatorDelegate?.goToLogin()
    }
    
    func signup(name: String, phone: String, email: String, id: String, licence: String, password: String) {
        delegate?.showSuccess(title: Strings.registrationTitle, message: Strings.registerationMessage)
    }
}
