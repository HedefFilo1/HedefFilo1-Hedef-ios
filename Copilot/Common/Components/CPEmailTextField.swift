//
//  CPEmailTextField.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation
import UIKit

class CPEmailTextField: CPTextField {
    
    private let imageView = UIImageView()
    private let errorLabel = UILabel()

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
        addErrorViews()
        keyboardType = .emailAddress
        placeholder = Strings.yourEmailAdress
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    func addErrorViews() {
        addSubview(imageView)
        imageView.align(toView: contentView, leading: 0, widthAndHeight: 16, topToBottom: 4)
        imageView.image = Images.errorIcon
        
        addSubview(errorLabel)
        errorLabel.align(toView: imageView, centerY: 0, leadingToTrailing: 8)
        errorLabel.text = errorMessage
        errorLabel.apply(TextStyle(fontStyle: .regular, size: 12), color: .fieldDescription)
        
        imageView.isHidden = true
        errorLabel.isHidden = true
    }
    
    @objc func editingChanged() {
        if validate() {
            imageView.isHidden = true
            errorLabel.isHidden = imageView.isHidden
            contentView.layer.borderColor = UIColor.borderColor.cgColor
        }
    }
    
    @objc func editingDidEnd() {
        let valid = validate()
        imageView.isHidden = valid
        errorLabel.isHidden = imageView.isHidden
        
        let color: UIColor = valid ? .borderColor: .theme
        contentView.layer.borderColor = color.cgColor
    }
}
