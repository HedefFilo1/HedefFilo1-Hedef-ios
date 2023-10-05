//
//  CPCheckBox.swift
//  Copilot
//
//  Created by Jamal on 10/2/23.
//

import Foundation
import UIKit

class CPCheckBox: UIView {
    
    let checkView = UIView()
    let imageView = UIImageView()
    
    var isSelected: Bool = false {
        didSet {
            checkView.isHidden = !isSelected
            layer.borderWidth = isSelected ? 0: 1
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
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightBorder.cgColor
        backgroundColor = .white
        clipsToBounds = true
        
        addSubview(checkView)
        checkView.align(all: 0)
        checkView.layer.cornerRadius = 4
        checkView.backgroundColor = .theme
        checkView.isHidden = true
        
        imageView.image = Images.check
        checkView.addSubview(imageView)
        imageView.align(all: 2)
    }
}
