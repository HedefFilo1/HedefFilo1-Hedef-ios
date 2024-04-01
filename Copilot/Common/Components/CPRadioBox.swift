//
//  CPRadioBox.swift
//  Copilot
//
//  Created by Jamal on 11/13/23.
//

import Foundation
import UIKit

class CPRadioBox: UIView {
    let button = UIView()
    
    var isSelected: Bool = false {
        didSet {
            button.isHidden = !isSelected
            let color: UIColor = isSelected ? .theme: .borderColor
            layer.borderColor = color.cgColor
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
        backgroundColor = .clear
        layer.cornerRadius = 10
        layer.borderColor = UIColor.borderColor.cgColor
        layer.borderWidth = 1
        addSubview(button)
        button.align(widthAndHeight: 10, centerX: 0, centerY: 0)
        button.backgroundColor = .theme
        button.layer.cornerRadius = 5
        button.isHidden = true
    }
}
