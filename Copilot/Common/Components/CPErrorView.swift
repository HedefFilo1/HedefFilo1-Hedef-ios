//
//  CPErrorView.swift
//  Copilot
//
//  Created by Jamal on 10/13/23.
//

import Foundation
import UIKit

class CPErrorView: UIView {
    
    var message = "" {
        didSet {
            errorLabel.text = message
        }
    }
    private let imageView = UIImageView()
    private let errorLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {

        addSubview(imageView)
        imageView.align(leading: 0, widthAndHeight: 16, centerY: 0)
        imageView.image = Images.errorIcon
        
        addSubview(errorLabel)
        errorLabel.align(toView: imageView, centerY: 0, leadingToTrailing: 8)
        errorLabel.text = Strings.error
        errorLabel.apply(TextStyle(fontStyle: .regular, size: 12), color: .fieldDescription)
    }
}
