//
//  CPButton.swift
//  Copilot
//
//  Created by Jamal on 10/2/23.
//

import Foundation
import UIKit

class CPButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            setEnabled()
        }
    }
    
    var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    var isSmallFontSize: Bool = false {
        didSet {
            if isSmallFontSize {
                setEnabled()
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
        layer.cornerRadius = 10
        isEnabled = false
    }
    
    private func setEnabled() {
        if isEnabled {
            backgroundColor = .theme
            apply(isSmallFontSize ? .whiteS16B700: .whiteS20B700)
            
        } else {
            backgroundColor = .disabled
            apply(TextStyle(fontStyle: .bold, size: isSmallFontSize ? 16: 20), color: .textDisabled)
        }
    }
    
}
