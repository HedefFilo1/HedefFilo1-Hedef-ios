//
//  CPSearchTextField.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import Foundation
import UIKit

class CPSearchTextField: UITextField {
   
    let searchIcon = UIImageView()
    
    var textPadding = UIEdgeInsets(top: 16, left: 54, bottom: 16, right: 20)
    var color = UIColor.white
    var title = Strings.searchFilter
    
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
        searchIcon.image = Images.search
        addSubview(searchIcon)
        searchIcon.align(leading: 20, widthAndHeight: 24, centerY: 0)
    }
    
    func applyStyles() {
        backgroundColor = .clear
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        borderStyle = .none
        apply(.whiteS16R400)
    }
    
    func setGreyTint() {
        searchIcon.image = Images.search.withRenderingMode(.alwaysTemplate)
        searchIcon.tintColor = .textGrey
        apply(.greyS16R400)
    }
    
    func setTint(color: UIColor) {
        self.color = color
        searchIcon.image = Images.search.withRenderingMode(.alwaysTemplate)
        searchIcon.tintColor = color
        setPlaceholder(title: title)
    }
    
    func setPlaceholder(title: String) {
        self.title = title
        let font = FontTypographyType.custom(color, .regular, 14).font
        attributedPlaceholder = NSAttributedString(string: title, attributes: [
            .foregroundColor: color,
            .font: font
        ])
    }
}
