//
//  CPDescriptionTextField.swift
//  Copilot
//
//  Created by Jamal on 3/6/24.
//

import Foundation
import UIKit

protocol CPDescriptionTextFieldDelegate: AnyObject {
    func didEditingChanged()
}

class CPDescriptionTextField: UIView {
    weak var delegate: CPDescriptionTextFieldDelegate?
    private var textView = UITextView()
    private let placeholderLabel = UILabel()
    private var placeholderTopConstraint: NSLayoutConstraint!
    private let countLabel = UILabel()
    private lazy var errorView = CPErrorView()
    private var errorViewAdded = false
    var errorMessage = ""
    var max = 300
    
    var text: String {
        get {
            textView.text
        }
        set {
            textView.text = newValue
        }
    }
    
    var placeholder: String? {
        didSet {
            let text = placeholder ?? ""
            placeholderLabel.text = text
            errorMessage = "\(Strings.pleaseEnterValid) \(text)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        applyConstraints()
        applyStyles()
        textView.delegate = self
        clipsToBounds = false
    }
    
    func applyConstraints() {
        addSubview(textView)
        textView.align(all: 16)
        
        addSubview(placeholderLabel)
        placeholderLabel.align(leading: 20, trailing: 16)
        placeholderTopConstraint = placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        placeholderLabel.adjustsFontSizeToFitWidth = true
        placeholderTopConstraint.isActive = true
        
        addSubview(countLabel)
        countLabel.align(trailing: 8, bottom: 8)
        countLabel.text = "Max: \(max)"
    }
    
    func applyStyles() {
        backgroundColor = .clear
        backgroundColor = .greyBorder.withAlphaComponent(0.4)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.greyBorder.cgColor
        textView.apply(.custom(.black, .regular, 14))
        placeholderLabel.apply(.greyS15B400)
        countLabel.apply(.greyS12R400)
        textView.backgroundColor = .clear
    }
    
    func resetTextField() {
//        placeholderTopConstraint.constant = 19
        placeholderLabel.apply(.greyS15B400)
        placeholderLabel.text = placeholder
        animate()
    }
    
    func clear() {
        text = ""
    }
}

extension CPDescriptionTextField: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.apply(.greyS12R400)
//        placeholderTopConstraint.constant = 6
        placeholderLabel.text = ""
        animate()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.count == 0 {
            showError(message: errorMessage)
            resetTextField()
        } else {
            
            hideError()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        countLabel.text = "Max: \(max - textView.text.count)"
        if textView.text.count > 0 {
            hideError()
        }
        delegate?.didEditingChanged()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.isEmpty { return true }
        
        if max - textView.text.count == 0 {
            return false
        }
        return true
    }
}

extension CPDescriptionTextField {
    
    var textCount: Int {
        let text = self.text
        return text.count
    }
    
    var pureTextCount: Int {
        var text = self.text
        text = text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return text.components(separatedBy: .whitespaces).joined().count
    }
    
    var pureText: String {
        var text = self.text
        text = text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return text.components(separatedBy: .whitespaces).joined()
    }
    
}

extension CPDescriptionTextField {
    func showError(message: String) {
        if !errorViewAdded {
            errorView.message = message
            addSubview(errorView)
            errorView.align(leading: 0, trailing: 0, bottom: -18, height: 16)
            errorViewAdded = true
        }
        self.layer.borderColor = UIColor.theme.cgColor
        errorView.isHidden = false
    }
    
    func hideError() {
        errorView.isHidden = true
        self.layer.borderColor = UIColor.borderColor.cgColor
    }
}
