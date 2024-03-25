//
//  RequestsTextField.swift
//  Copilot
//
//  Created by Jamal on 3/24/24.
//

import Foundation
import UIKit

protocol RequestsTextFieldType: CPTextField {
    
}

extension RequestsTextFieldType {
    
    func disable(withText text: String) {
        preText = text
        isEnabled = false
    }
    
    func customize() {
        apply(.custom(.black, .regular, 14))
        contentView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        placeholderLabel.isHidden = true
        textPadding.top = 0
        textPadding.bottom = 0
    }
}

class RequestsTextField: CPValidatableTextField, RequestsTextFieldType {
    
    override var placeholder: String? {
        didSet {
            let text = placeholderLabel.text ?? ""
            attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.textFieldGreyText])
            errorMessage = "\(Strings.pleaseEnterValid) \(text)"
        }
    }
    
    override func setup() {
        super.setup()
       customize()
    }
    
    override func validate() -> Bool {
        if let validationDelegate {
            return validationDelegate.validate(textField: self)
        }
        let string = text ?? ""
        return string.count > 0 
    }
}

class RequestsPhoneTextField: CPPhoneTextField, RequestsTextFieldType {

    override var placeholder: String? {
        didSet {
            let text = placeholderLabel.text ?? ""
            attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.textFieldGreyText])
        }
    }
    
    override func setup() {
        super.setup()
        customize()
        keyboardType = .phonePad
    }
    
    override func didEnd() {
//        super.didEnd()
//        if let text, text.count == 0 {
//            placeholder = Strings.phoneNumber
//        }
    }
}
