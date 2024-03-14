//
//  CPPhoneTextField.swift
//  Copilot
//
//  Created by Jamal on 11/2/23.
//

import Foundation
import UIKit

class CPPhoneTextField: CPEmailTextField {
    
    var number: String {
        return text?.components(separatedBy: .whitespaces).joined() ?? ""
    }
    
    override func validate() -> Bool {
        return pureTextCount == 11
    }
    
    override func setup() {
        super.setup()
        keyboardType = .phonePad
        placeholder = Strings.phoneNumber
        errorMessage = Strings.enterValidPhone
        delegate = self
    }
    
    override func editingChanged() {
        super.editingChanged()
        text = text?.applyPatternOnNumbers(pattern: CodeStrings.phonePattern, replacementCharacter: "#")
    }
    
    func setMask(text: String) {
        attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.fieldDescription])
    }
    
    override func didBegin() {
        super.didBegin()
        setMask(text: CodeStrings.phoneMask)
    }
    
    override func didEnd() {
        super.didEnd()
        setMask(text: "")
    }
}

extension CPPhoneTextField {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        return range.location < 14
    }
}
