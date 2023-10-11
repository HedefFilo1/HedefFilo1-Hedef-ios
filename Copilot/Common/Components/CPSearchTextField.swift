//
//  CPSearchTextField.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import Foundation
import UIKit

class CPSearchTextField: UITextField {
   
    var textPadding: UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 54, bottom: 16, right: 20)
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
        setImageView()
        applyStyles()
    }
    
    func setImageView() {
        let imageView = UIImageView()
        imageView.image = Images.search
        addSubview(imageView)
        imageView.align(leading: 20, widthAndHeight: 24, centerY: 0)
    }
    
    func applyStyles() {
        backgroundColor = .clear
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        apply(.whiteS16R400)
    }
}
