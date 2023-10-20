//
//  LoginViewModel.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func goToMain()
    func goToForgotPassword()
    func goToSignup()
}

protocol LoginViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
}

protocol LoginViewModelType: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }
    func goToMain()
    func goToForgotPassword()
    func login(email: String, password: String)
    func goToSignup()
}

class LoginViewModel: LoginViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?
    weak var delegate: LoginViewModelDelegate?
    
    func goToMain() {
        coordinatorDelegate?.goToMain()
    }
    
    func goToForgotPassword() {
        coordinatorDelegate?.goToForgotPassword()
    }
    
    func login(email: String, password: String) {
//
        Loading.shared.show(title: Strings.loading)
        
        APIService.login(email: email,
                          password: password) { [weak self] model, _ in
            
            Loading.shared.hide()
            guard let self = self else {return}
            
            guard model != nil else {
                self.delegate?.showError(title: Strings.incorrectInfo,
                                         message: Strings.loginTryAgainMessage)
                return
            }
            self.goToMain()
            
        }
    }
    
    func goToSignup() {
        coordinatorDelegate?.goToSignup()
    }
}
