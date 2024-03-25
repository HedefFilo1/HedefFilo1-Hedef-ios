//
//  RequestsDropDownList.swift
//  Copilot
//
//  Created by Jamal on 3/26/24.
//

import Foundation
import UIKit

class RequestsDropDownList: CPDropDownList {
    
    override func setValueLabel() {
        headView.addSubview(valueLabel)
        valueLabel.align(top: 16, leading: 16)
        valueLabel.align(toView: chevronImageView, lessThanOrEqualTraling: 10)
        valueLabel.apply(.custom(.black, .regular, 14))
    }
    
    override func setSelectedStyles() {
        super.setSelectedStyles()
        titleLabel.isHidden = true
        
    }
}
