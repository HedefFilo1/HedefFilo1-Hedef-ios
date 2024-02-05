//
//  CPPointButton.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation
import UIKit

class CPPointButton: UIView {
    
    let centerView = UIView()
    
    var isEnabled: Bool = false {
        didSet {
            layer.borderWidth = isEnabled ? 1: 0
            centerView.backgroundColor = isEnabled ? .theme: .borderColor
            if !isEnabled {
                boxShadow(xValue: 1, yValue: 1, radius: 2, color: .black, opacity: 0.1)
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
    
    func setup() {
        layer.cornerRadius = 9
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightRed.cgColor
        backgroundColor = .white
        clipsToBounds = true
        
        addSubview(centerView)
        centerView.align(widthAndHeight: 9, centerX: 0, centerY: 0)
        centerView.layer.cornerRadius = 9/2
        centerView.backgroundColor = .theme
        centerView.isHidden = true
    }
}
