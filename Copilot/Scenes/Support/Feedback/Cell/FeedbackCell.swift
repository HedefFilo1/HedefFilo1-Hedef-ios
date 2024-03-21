//
//  FeedbackCell.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.03.2024.
//

import UIKit

class FeedbackCell: UICollectionViewCell, Reusable {

    var item: SupportGuide? {
        didSet {
            titleLabel.text = item?.title
        }
    }
    
    // MARK: - IBOutlets
    // MARK: - UILabels
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        titleLabel.apply(.blackS14M500)
    }
    
    public func configure(titleText: String) {
        titleLabel.text = titleText
    }

}
