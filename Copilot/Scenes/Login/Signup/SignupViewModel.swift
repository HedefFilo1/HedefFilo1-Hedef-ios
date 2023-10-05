//
//  SignupViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/5/23.
//

import Foundation

protocol SignupViewModelCoordinatorDelegate: AnyObject {
    func goToNextScene()
    func goToLogin()
}

protocol SignupViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
}

protocol SignupViewModelType: AnyObject {
    var delegate: SignupViewModelDelegate? { get set }
    func goToNextScene()
    func goToLogin()
    func signup(name: String, phone: String, email: String, id: String, licence: String, password: String)
}

class SignupViewModel: SignupViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: SignupViewModelCoordinatorDelegate?
    weak var delegate: SignupViewModelDelegate?
    
    func goToNextScene() {
        coordinatorDelegate?.goToNextScene()
    }
    
    func goToLogin() {
        coordinatorDelegate?.goToLogin()
    }
    
    func signup(name: String, phone: String, email: String, id: String, licence: String, password: String) {
        goToNextScene()
    }
}
