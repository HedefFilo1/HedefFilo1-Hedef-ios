//
//  LoginViewModel.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func goToNextScene()
    func goToForgotPassword()
    func goToSignup()
}

protocol LoginViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
}

protocol LoginViewModelType: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }
    func goToNextScene()
    func goToForgotPassword()
    func login(email: String, password: String)
    func goToSignup()
}

class LoginViewModel: LoginViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?
    weak var delegate: LoginViewModelDelegate?
    
    func goToNextScene() {
        coordinatorDelegate?.goToNextScene()
    }
    
    func goToForgotPassword() {
        coordinatorDelegate?.goToForgotPassword()
    }
    
    func login(email: String, password: String) {
        goToNextScene()
    }
    
    func goToSignup() {
        coordinatorDelegate?.goToSignup()
    }
}
