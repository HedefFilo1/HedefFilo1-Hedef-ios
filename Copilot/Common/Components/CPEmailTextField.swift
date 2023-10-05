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
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    func addErrorViews() {
        addSubview(imageView)
        imageView.align(toView: contentView, leading: 0, widthAndHeight: 16, topToBottom: 4)
        imageView.image = Images.errorIcon
        
        addSubview(errorLabel)
        errorLabel.align(toView: imageView, centerY: 0, leadingToTrailing: 8)
        errorLabel.text = Strings.emailIncorrect
        errorLabel.apply(TextStyle(fontStyle: .regular, size: 12), color: .fieldDescription)
        
        imageView.isHidden = true
        errorLabel.isHidden = true
    }
    
    @objc func editingDidEnd() {
        imageView.isHidden = validate()
        errorLabel.isHidden = imageView.isHidden
    }
}
