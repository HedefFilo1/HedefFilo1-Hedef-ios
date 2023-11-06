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
    func showSuccess(title: String, message: String, delegate: MessagePopupViewControllerDelegate?)
}

protocol SignupViewModelType: AnyObject {
    var delegate: SignupViewModelDelegate? { get set }
    func goToLogin()
    func signup(name: String,
                surname: String,
                phone: String,
                email: String,
                taxId: String,
                plateNumber: String,
                licence: String,
                password: String,
                phonePermission: Bool,
                smsPermission: Bool,
                emailPermission: Bool)
}

class SignupViewModel: SignupViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: SignupViewModelCoordinatorDelegate?
    weak var delegate: SignupViewModelDelegate?
    
    func goToLogin() {
        coordinatorDelegate?.goToLogin()
    }
    
    func signup(name: String,
                surname: String,
                phone: String,
                email: String,
                taxId: String,
                plateNumber: String,
                licence: String,
                password: String,
                phonePermission: Bool,
                smsPermission: Bool,
                emailPermission: Bool) {
        
        Loading.shared.show(title: Strings.loading)
        
        let number = phone.components(separatedBy: .whitespaces).joined()
        APIService.signup(name: name,
                          surname: surname,
                          phoneNumber: number,
                          email: email,
                          plateNumber: plateNumber,
                          licenseNumber: licence,
                          password: password,
                          taxId: taxId,
                          phonePermission: phonePermission,
                          smsPermission: smsPermission,
                          emailPermission: emailPermission) { [weak self] _, error in
            
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
            
            self.delegate?.showSuccess(title: Strings.registrationTitle, message: Strings.registerationMessage, delegate: self)
        }
    }
}

extension SignupViewModel: MessagePopupViewControllerDelegate {
    func didDismiss(_: SuccessPopupViewController?) {
        coordinatorDelegate?.goToLogin()
    }
}
