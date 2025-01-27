//
//  LoginViewModel.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func goToAvatar(email: String)
    func loginDidFinish()
    func goToForgotPassword()
    func goToSignup()
}

protocol LoginViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
    func set(email: String, password: String)
}

protocol LoginViewModelType: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }
    func goToForgotPassword()
    func login(email: String, password: String, rememberMe: Bool)
    func goToSignup()
    func checkRememberMe()
    func goToNextScene(email: String)
    func loginDidFinish()
}

class LoginViewModel: LoginViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?
    weak var delegate: LoginViewModelDelegate?
    
    func loginDidFinish() {
        coordinatorDelegate?.loginDidFinish()
    }
    
    func goToForgotPassword() {
        coordinatorDelegate?.goToForgotPassword()
    }
    
    func checkRememberMe() {
        if let token = Persistence.accessToken, token.count > 3 {
            self.loginDidFinish()
            return
        }
        
        if let email = Persistence.userEmail, let password = Persistence.password {
            self.delegate?.set(email: email, password: password)
        }
    }
    
    func login(email: String, password: String, rememberMe: Bool) {
        // just for test
        if email == "tester@solid.com" && password == "123456" {
            self.goToNextScene(email: "tester@solid.com")
            return
        }
#if DEV_DEBUG
//        Persistence.rememberMe = rememberMe
//        if rememberMe {
//            Persistence.userEmail = email
//            Persistence.password = password
//            Persistence.accessToken =  "some token"
//        } else {
//            Persistence.userEmail = nil
//            Persistence.password = nil
//            Persistence.accessToken =  nil
//        }
//        goToNextScene(email: email)
        
//        if 
#endif
        Loading.shared.show(title: Strings.loading)
        APIService.login(email: email,
                         password: password) { [weak self] model, error in
            
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
            
            if let model = model {
                App.token = model.token
                Persistence.rememberMe = rememberMe
                if rememberMe {
                    Persistence.userEmail = email
                    Persistence.password = password
                    Persistence.accessToken =  model.token
                } else {
                    Persistence.userEmail = nil
                    Persistence.password = nil
                    Persistence.accessToken =  nil
                }
                APIService.addUserAction(pageName: "LOGIN", actionName: "LOGIN")
                APIService.addUserAction(pageName: "LOGIN", actionName: "LOGIN_PAGE_LOAD")
                APIService.addUserAction(pageName: "LOGIN", actionName: "LOGIN_PAGE_LOAD_LOG_IN")
                self.goToNextScene(email: email)
            }
            
        }
    }
    
    func goToNextScene(email: String) {
        if let selected = Persistence.avatarSelected, email == selected {
            loginDidFinish()
        } else {
            coordinatorDelegate?.goToAvatar(email: email)
        }
    }
    
    func goToSignup() {
        coordinatorDelegate?.goToSignup()
    }
}
