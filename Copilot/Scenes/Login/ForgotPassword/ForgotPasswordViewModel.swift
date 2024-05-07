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
    func showSuccess(title: String, message: String, buttonTitle: String)
    func showError(title: String, message: String)
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
        
        Loading.shared.show(title: Strings.loading)
        
        let number = phone.components(separatedBy: .whitespaces).joined()
        APIService.forgotPassword(email: email, phoneNumber: number) { [weak self] _, error in
            
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle, message: error.message)
                return
            }
            APIService.addUserAction(pageName: "LOGIN", actionName: "LOGIN_PAGE_LOAD_FORGOT_PASSWORD")
            let title = App.getString(key: "copilotapp.forgot.password.success.title") ?? ""
            let message = App.getString(key: "copilotapp.forgot.password.success.description") ?? ""
            let button = App.getString(key: "copilotapp.forgot.password.success.button") ?? ""
            self.delegate?.showSuccess(title: title,
                                       message: message, 
                                       buttonTitle: button)
        }
        
    }
}
