//
//  CPPasswordTextField.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation
import UIKit

class CPPasswordTextField: CPTextField {
    
    override var textPadding: UIEdgeInsets {
        var padding = super.textPadding
        padding.right = 48
        return padding
    }
    
    private let imageView = UIImageView()
    private let showButton = UIButton()
    private var showPassword = false
    
    override func setup() {
        super.setup()
        isSecureTextEntry = true
        
        addSubviews(views: imageView, showButton)
        imageView.image = Images.passwordMask
        imageView.align(trailing: 16, widthAndHeight: 24, centerY: 0)
        imageView.contentMode = .scaleAspectFit
        
//        imageView.isHidden = true
//        showButton.isEnabled = false
        
        showButton.align(toView: imageView, widthAndHeight: 40, centerX: 0, centerY: 0)
        showButton.addTarget(self, action: #selector(didTapShowPassword), for: .touchUpInside)
        placeholder  = Strings.password
                
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
    }
    
    @objc func didTapShowPassword() {
        showPassword = !showPassword
        isSecureTextEntry = !showPassword
//        imageView.image = showPassword ? Images.passwordMask: Images.
    }
    
    @objc func editingDidBegin() {
//        imageView.isHidden = false
//        showButton.isEnabled = true
    }
    
    @objc func editingChanged() {
        
    }
    
    @objc func editingDidEnd() {
//        super.didBegin()
//        imageView.isHidden = !(pureTextCount > 0)
//        showButton.isEnabled = pureTextCount > 0
//        contentView.layer.borderColor = UIColor.primaryBlue50.cgColor
    }
    
}
