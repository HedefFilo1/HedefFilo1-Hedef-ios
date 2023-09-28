//
//  CPLightButton.swift
//  Copilot
//
//  Created by Jamal on 9/28/23.
//

import Foundation
import UIKit

class CPLightButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {

        }
    }
    
    var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
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
        layer.cornerRadius = 10
        backgroundColor = .white
        layer.borderColor = UIColor.theme.cgColor
        layer.borderWidth = 1
        apply(.themeS16B700)
        isEnabled = true
    }
    
}
