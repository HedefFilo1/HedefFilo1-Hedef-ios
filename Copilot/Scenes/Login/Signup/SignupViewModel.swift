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
    var min8Rule: Bool { get set }
    var uppercaseRule: Bool { get set }
    var lowercaseRule: Bool { get set }
    var numberRule: Bool { get set }
    var specialRule: Bool { get set }
    var allRules: Bool { get }
    func check(password: String)
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
    
    var min8Rule: Bool = false
    var uppercaseRule: Bool = false
    var lowercaseRule: Bool = false
    var numberRule: Bool = false
    var specialRule: Bool = false
    var otpId = ""
    
    var allRules: Bool {
        return min8Rule && uppercaseRule && lowercaseRule && numberRule && specialRule
    }
    
    func goToLogin() {
        coordinatorDelegate?.goToLogin()
    }
    
    func check(password: String) {
        min8Rule = password.count > 7
        uppercaseRule = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        lowercaseRule = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        numberRule = password.rangeOfCharacter(from: .decimalDigits) != nil
        specialRule = password.rangeOfCharacter(from: .punctuationCharacters) != nil
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
