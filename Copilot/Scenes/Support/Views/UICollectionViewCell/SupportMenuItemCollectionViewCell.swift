//
//  SupportMenuItemCollectionViewCell.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.03.2024.
//

import UIKit

class SupportMenuItemCollectionViewCell: UICollectionViewCell, Reusable {

    // MARK: - IBOutlets
    // MARK: - UILabels
    @IBOutlet private weak var titleLabel: UILabel!
    
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
