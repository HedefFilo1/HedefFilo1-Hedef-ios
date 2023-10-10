//
//  ForgotPasswordViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import Foundation

protocol ForgotPasswordVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol ForgotPasswordViewModelDelegate: AnyObject {
    func showSuccess(title: String, message: String)
}

protocol ForgotPasswordViewModelType: AnyObject {
    var delegate: ForgotPasswordViewModelDelegate? { get set }
    func getBack()
    func sendPassword(email: String, phone: String)
}

class ForgotPasswordViewModel: ForgotPasswordViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: ForgotPasswordVMCoordinatorDelegate?
    weak var delegate: ForgotPasswordViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func sendPassword(email: String, phone: String) {
        delegate?.showSuccess(title: Strings.passwordHasBeenSent,
                              message: Strings.passwordSentToEmail)
    }
}
