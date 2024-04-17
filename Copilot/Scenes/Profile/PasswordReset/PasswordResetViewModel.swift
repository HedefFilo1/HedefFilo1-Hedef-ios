//
//  PasswordReset.swift
//  Copilot
//
//  Created by Jamal on 10/29/23.
//

import Foundation

protocol PasswordResetVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol PasswordResetViewModelDelegate: AnyObject {
    func showSuccess(title: String, message: String, delegate: MessagePopupViewControllerDelegate?)
    func showError(title: String, message: String)
}

protocol PasswordResetViewModelType: AnyObject {
    var delegate: PasswordResetViewModelDelegate? { get set }
    var min8Rule: Bool { get set }
    var uppercaseRule: Bool { get set }
    var lowercaseRule: Bool { get set }
    var numberRule: Bool { get set }
    var specialRule: Bool { get set }
    var allRules: Bool { get }
    func check(password: String)
    func setPassword(old: String, new: String)
    func getBack()
}

class PasswordResetViewModel: PasswordResetViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: PasswordResetVMCoordinatorDelegate?
    weak var delegate: PasswordResetViewModelDelegate?
    
    var min8Rule: Bool = false
    var uppercaseRule: Bool = false
    var lowercaseRule: Bool = false
    var numberRule: Bool = false
    var specialRule: Bool = false
    var otpId = ""
    
    var allRules: Bool {
        return min8Rule && uppercaseRule && lowercaseRule && numberRule && specialRule
    }
    
    func check(password: String) {
        min8Rule = password.count > 7
        uppercaseRule = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        lowercaseRule = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        numberRule = password.rangeOfCharacter(from: .decimalDigits) != nil
        specialRule = password.rangeOfCharacter(from: .punctuationCharacters) != nil
    }
    
    func setPassword(old: String, new: String) {
        Loading.shared.show(title: Strings.loading)
        APIService.setPassword(old: old, new: new) { [weak self] _, error in
            
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle, message: error.message)
                return
            }
            APIService.addUserAction(pageName: "PROFILE", actionName: "PROFILE_SAVE")
            self.delegate?.showSuccess(title: Strings.passwordUpdated, message: "", delegate: self)
        }
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}

extension PasswordResetViewModel: MessagePopupViewControllerDelegate {
    func didDismiss(_: SuccessPopupViewController?) {
        getBack()
    }
}
