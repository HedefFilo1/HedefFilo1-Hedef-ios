//
//  CPGreyButton.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation
import UIKit

class CPGreyButton: CPLightButton {
    
    override func setup() {
        super.setup()
        layer.borderColor = UIColor.textGrey.cgColor
        apply(.greyS16B700)
    }
}
