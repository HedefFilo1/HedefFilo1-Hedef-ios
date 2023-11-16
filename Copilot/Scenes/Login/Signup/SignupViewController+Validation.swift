//
//  SignupViewController+Validation.swift
//  Copilot
//
//  Created by Jamal on 11/16/23.
//

import Foundation
import UIKit

extension SignupViewController: CPValidatableTextFieldDelegate, UITextFieldDelegate {
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField == plateNumberTextField || textField == licenseTextField {
            textField.text = textField.text?.uppercased()
        }
        if textField == repeatPasswordTextFiled {
            let pass = passwordTextFiled.text ?? ""
            let repeatPass = repeatPasswordTextFiled.text ?? ""
            if pass == repeatPass {
                repeatPasswordTextFiled.hideError()
            }
        }
        
        if textField == passwordTextFiled {
            checkRules()
        }
        setButtonActivation()
    }
    
    @objc func editingDidEnd(_ textField: UITextField) {
        let repeatPass = repeatPasswordTextFiled.text ?? ""
        if textField == passwordTextFiled, repeatPass.count > 0 {
            checkPasswords()
        }
        if textField == repeatPasswordTextFiled {
            checkPasswords()
        }
    }
    
    func setButtonActivation() {
        let name = nameTextField.validate()
        let surname = surnameTextField.validate()
        let phone = phoneTextField.validate()
        let email = emailTextFiled.validate()
        let tcTax = taxTextField.validate()
        let plate = plateNumberTextField.validate()
        let license = licenseTextField.validate()
        let pass = passwordTextFiled.text ?? ""
        let repeatPass = repeatPasswordTextFiled.text ?? ""
        let passes = pass.count > 0 && repeatPass.count > 0 && pass == repeatPass
        let clarification = clarificationCheckBox.isSelected
        signupButton.isEnabled = name && surname && phone && email && tcTax && plate && license && passes && clarification
    }
    
    func validate(textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            return nameTextField.pureTextCount > 0
            
        case surnameTextField:
            return surnameTextField.pureTextCount > 0
            
        case taxTextField:
            return taxTextField.textCount == 10
            
        case plateNumberTextField:
            let count = plateNumberTextField.pureTextCount
            return count == 7 || count == 8
            
        case licenseTextField:
            let text = licenseTextField.pureText
            let letters = String(text.prefix(2))
            if letters.isLetterString, letters.count == 2 {
                textField.keyboardType = .numberPad
                textField.reloadInputViews()
            } else {
                textField.keyboardType = .namePhonePad
                textField.reloadInputViews()
            }
            let numbers = text.replacingOccurrences(of: letters, with: "")
            return numbers.isNumber && letters.isLetterString && text.count == 8
            
        default:
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        
        if textField == nameTextField || textField == surnameTextField {
            var allowedCharacters = CharacterSet.letters
            allowedCharacters.insert(" ")
            let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
            return unwantedStr.count == 0
            
        }
        
        if textField == licenseTextField || textField == plateNumberTextField {
            return range.location < 8
        }
        return range.location < 10
    }
    
    func checkPasswords() {
        let pass = passwordTextFiled.text ?? ""
        let repeatPass = repeatPasswordTextFiled.text ?? ""
        if pass != repeatPass {
            repeatPasswordTextFiled.showError(message: Strings.passwordsShouldBeSame)
        } else {
            repeatPasswordTextFiled.hideError()
        }
    }
    
    func checkRules() {
        let new = passwordTextFiled.text ?? ""
        viewModel.check(password: new)
        minLabel.textColor = viewModel.min8Rule ? .textSuccess: .theme
        uppercaseLabel.textColor = viewModel.uppercaseRule ? .textSuccess: .theme
        lowercaseLabel.textColor = viewModel.lowercaseRule ? .textSuccess: .theme
        numberLabel.textColor = viewModel.numberRule ? .textSuccess: .theme
        specialLabel.textColor = viewModel.specialRule ? .textSuccess: .theme
    }
}
