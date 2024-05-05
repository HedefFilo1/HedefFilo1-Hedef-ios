//
//  CPEmailTextField.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation
import UIKit

class CPEmailTextField: CPValidatableTextField {
    
    override func validate() -> Bool {
        let emailFormat = CodeStrings.emailFormat
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: text)
    }
    
    override func setup() {
        super.setup()
        keyboardType = .emailAddress
        placeholder = App.getString(key: "copilotapp.sign.in.email.input.description")
        errorMessage = Strings.emailIncorrect
    }
}
