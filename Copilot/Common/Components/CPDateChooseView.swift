//
//  CPDateChooseView.swift
//  Copilot
//
//  Created by Jamal on 1/2/24.
//

import Foundation
import UIKit

protocol CPDateChooseViewDelegate: AnyObject {
    func didTap(_: CPDateChooseView)
}

class CPDateChooseView: UIView {
    
    weak var delegate: CPDateChooseViewDelegate?
    
    var date: String = "" {
        didSet {
            label.text = date
        }
    }
    
    let label = UILabel()
    let icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        clipsToBounds = true
        addSubview(label)
        label.align(leading: 16, centerY: 0)
        label.apply(.custom(.fieldsText, .regular, 16))
        label.text = "06 Ocak 2023 Cuma"
        
        addSubview(icon)
        icon.align(trailing: 20, widthAndHeight: 24, centerY: 0)
        label.align(toView: icon, trailingToLeading: 4)
        icon.image = Images.calendarIcon
        
        let button = UIButton()
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        addSubview(button)
        button.align(all: 0)
    }
    
    @objc func didTap() {
        delegate?.didTap(self)
    }
}
