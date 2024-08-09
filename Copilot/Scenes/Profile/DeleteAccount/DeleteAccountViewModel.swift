//
//  DeleteAccountViewModel.swift
//  Copilot
//
//  Created by Jamal on 8/9/24.
//

import Foundation

protocol DeleteAccountVMCoordinatorDelegate: AnyObject {
    
}

protocol DeleteAccountViewModelDelegate: BaseViewModelDelegate {
    func didDeleteAccount()
}

protocol DeleteAccountViewModelType: AnyObject {
    var coordinatorDelegate: DeleteAccountVMCoordinatorDelegate? { get set }
    var delegate: DeleteAccountViewModelDelegate? { get set }
    func deleteAccount()
}

class DeleteAccountViewModel: DeleteAccountViewModelType {
    
    weak var coordinatorDelegate: DeleteAccountVMCoordinatorDelegate?
    weak var delegate: DeleteAccountViewModelDelegate?
    
    func deleteAccount() {
        APIService.deleteMyAccount { [weak self] _, error in
            
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle, message: error.message)
                return
            }
            
            self.delegate?.didDeleteAccount()
            App.appCoordinator?.logout()
        }
    }
}
