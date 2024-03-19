//
//  SupportItemCell.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.03.2024.
//

import UIKit

class SupportItemCell: UICollectionViewCell, Reusable {

    // MARK: - IBOutlets
    // MARK: - UILabels
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        titleLabel.apply(.blackS14R400)
    }
    
    public func configure(titleText: String) {
        titleLabel.text = titleText
    }

}
