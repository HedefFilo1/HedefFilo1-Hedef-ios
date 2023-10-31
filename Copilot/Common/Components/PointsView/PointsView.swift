//
//  PointsView.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import UIKit

class PointsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
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

    }
}
