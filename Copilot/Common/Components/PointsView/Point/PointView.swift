//
//  PointView.swift
//  Copilot
//
//  Created by Jamal on 3/27/24.
//

import Foundation
import UIKit

class PointView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    private var nibName: String {
        return String(describing: type(of: self))
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        applyStyles()
    }
    
    private func applyStyles() {
        backgroundColor = .clear
        circleView.layer.cornerRadius = 12
        circleView.layer.borderWidth = 1
        circleView.layer.borderColor = UIColor.pink.cgColor
        circleView.backgroundColor = .white
        titleLabel.apply(.blackS12B700)
        valueLabel.apply(.blackS12R400)
    }
    
}
