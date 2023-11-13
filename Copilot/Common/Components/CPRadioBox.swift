//
//  CPRadioBox.swift
//  Copilot
//
//  Created by Jamal on 11/13/23.
//

import Foundation
import UIKit

class CPRadioBox: CPCheckBox {
    
    override func setup() {
        super.setup()
        layer.cornerRadius = 10
        layer.borderColor = UIColor.textGrey.cgColor
    }
}
