//
//  PasswordReset.swift
//  Copilot
//
//  Created by Jamal on 10/29/23.
//

import Foundation

protocol PasswordResetViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol PasswordResetViewModelDelegate: AnyObject {
    
}

protocol PasswordResetViewModelType: AnyObject {
    var delegate: PasswordResetViewModelDelegate? { get set }
    func getBack()
}

class PasswordResetViewModel: PasswordResetViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: PasswordResetViewModelCoordinatorDelegate?
    weak var delegate: PasswordResetViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}
