//
//  CPValidatableTextField.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation
import UIKit

protocol CPValidatableTextFieldDelegate: AnyObject {
    func validate(textField: UITextField)-> Bool
}

class CPValidatableTextField: CPTextField {

    weak var validationDelegate: CPValidatableTextFieldDelegate?
    var isValidText: Bool {
        return validate()
    }
    
    var errorMessage = ""
    
    func validate() -> Bool {
        return validationDelegate?.validate(textField: self) ?? false
    }
    
    override func setup() {
        super.setup()
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    @objc func editingChanged() {
        if validate() {
            hideError()
        }
    }
    
    @objc func editingDidEnd() {
        checkValidation()
    }
    
    func checkValidation() {
        if validate() {
            hideError()
        } else {
            showError(message: errorMessage)
        }
    }
}
