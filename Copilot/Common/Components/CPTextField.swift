//
//  CPTextField.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation
import UIKit

class CPTextField: UITextField {
    
    let contentView = UIView()
    private let placeholderLabel = UILabel()
    private var validationLabel: UILabel?
    private var placeholderTopConstraint: NSLayoutConstraint!
    private lazy var errorView = CPErrorView()
    private var errorViewAdded = false
    
    var textPadding: UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 16, bottom: 12, right: 16)
    }
    
    var preText: String? {
        didSet {
            sendActions(for: .editingDidBegin)
            text = preText
            sendActions(for: .editingDidEnd)
            sendActions(for: .editingChanged)
        }
    }
    
    override var text: String? {
        didSet {
        }
    }
    
    override var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
            attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.clear])
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if !isEnabled {
                textColor = .textGrey
            }
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
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
        
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    func setup() {
        spellCheckingType = .no
        autocorrectionType = .no
        applyConstraints()
        addTargets()
        applyStyles()
        delegate = self
    }
    
    func applyConstraints() {
        contentView.isUserInteractionEnabled = false
        addSubview(contentView)
        contentView.align(top: 0, height: 56, leadingAndTrailing: 0)
        contentView.addSubviews(views: placeholderLabel)
        placeholderLabel.align(leading: 16, trailing: 16)
        placeholderTopConstraint = placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 19)
        placeholderLabel.adjustsFontSizeToFitWidth = true
        placeholderTopConstraint.isActive = true
        
    }
    
    func addTargets() {
        addTarget(self, action: #selector(didBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(didEnd), for: .editingDidEnd)
    }
    
    func applyStyles() {
        borderStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.borderColor.cgColor
        apply(.blackS15B400)
        placeholderLabel.apply(.greyS15B400)
    }
    
    func resetTextField() {
        placeholderTopConstraint.constant = 19
        placeholderLabel.apply(.greyS15B400)
        animate()
    }
    
    func clear() {
        text = ""
        sendActions(for: .editingDidEnd)
    }
}

extension CPTextField: UITextFieldDelegate {
    
    @objc func didBegin() {
        if let text = text, text.count == 0 {
            placeholderLabel.apply(.greyS12R400)
            placeholderTopConstraint.constant = 6
            animate()
        }
    }
    
    @objc func didEnd() {
        text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let text = text, text.count > 0 {
            // checkValidation()
        } else {
            resetTextField()
        }
    }
}

extension CPTextField {
    
    var textCount: Int {
        let text = self.text ?? ""
        return text.count
    }
    
    var pureTextCount: Int {
        var text = self.text ?? ""
        text = text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return text.components(separatedBy: .whitespaces).joined().count
    }
    
    var pureText: String {
        var text = self.text ?? ""
        text = text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return text.components(separatedBy: .whitespaces).joined()
    }
    
}

// MARK: handle errorView
extension CPTextField {
    
    func showError(message: String) {
        if !errorViewAdded {
            errorView.message = message
            addSubview(errorView)
            errorView.align(toView: contentView, leading: 0, trailing: 0, height: 16, topToBottom: 4)
            errorViewAdded = true
        }
        contentView.layer.borderColor = UIColor.theme.cgColor
        errorView.isHidden = false
    }
    
    func hideError() {
        errorView.isHidden = true
        contentView.layer.borderColor = UIColor.borderColor.cgColor
    }
}
