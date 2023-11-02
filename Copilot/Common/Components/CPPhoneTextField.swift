//
//  CPPhoneTextField.swift
//  Copilot
//
//  Created by Jamal on 11/2/23.
//

import Foundation
import UIKit

class CPPhoneTextField: CPEmailTextField {
    
    override var errorMessage: String {
        return Strings.enterValidPhone
    }
    
    override func validate() -> Bool {
        return pureTextCount == 11
    }
    
    override func setup() {
        super.setup()
        keyboardType = .phonePad
        placeholder = Strings.phoneNumber
        delegate = self
    }
    
    override func editingChanged() {
        super.editingChanged()
        text = text?.applyPatternOnNumbers(pattern: CodeStrings.phonePattern, replacementCharacter: "#")
    }
}

extension CPPhoneTextField {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        return range.location < 14
    }
}
