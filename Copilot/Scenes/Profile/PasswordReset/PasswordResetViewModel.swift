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
    func getBack()
}

class PasswordResetViewModel: PasswordResetViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: PasswordResetVMCoordinatorDelegate?
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
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}
