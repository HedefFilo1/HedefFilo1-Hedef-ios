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
            placeholderLabel.text = placeholder
            
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
    }
    
    func applyConstraints() {
        addSubview(textView)
        textView.align(all: 16)
        
        addSubview(placeholderLabel)
        placeholderLabel.align(leading: 20, trailing: 16)
        placeholderTopConstraint = placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
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
        textView.apply(.custom(.textFieldGreyText, .regular, 14))
        placeholderLabel.apply(.greyS15B400)
        countLabel.apply(.greyS12R400)
        textView.backgroundColor = .clear
    }
    
    func resetTextField() {
        placeholderTopConstraint.constant = 19
        placeholderLabel.apply(.greyS15B400)
        animate()
    }
    
    func clear() {
        text = ""
    }
}

extension CPDescriptionTextField: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.apply(.greyS12R400)
        placeholderTopConstraint.constant = 6
        animate()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.count == 0 {
            resetTextField()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        countLabel.text = "Max: \(max - textView.text.count)"
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
