//
//  CPEmailTextField.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation
import UIKit

class CPEmailTextField: CPTextField {

    var isValidText: Bool {
        return validate()
    }
    
    var errorMessage: String {
        return Strings.emailIncorrect
    }
    
    func validate() -> Bool {
        let emailFormat = CodeStrings.emailFormat
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: text)
    }
    
    override func setup() {
        super.setup()
        keyboardType = .emailAddress
        placeholder = Strings.yourEmailAdress
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    @objc func editingChanged() {
        if validate() {
            hideError()
        }
    }
    
    @objc func editingDidEnd() {
        if validate() {
            hideError()
        } else {
            showError(message: errorMessage)
        }
    }
}
