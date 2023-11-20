//
//  PastSearchCell.swift
//  Copilot
//
//  Created by Jamal on 11/17/23.
//

import UIKit

class PastSearchCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        searchImageView.image = Images.search.withRenderingMode(.alwaysTemplate)
        searchImageView.tintColor = .lightBlack
        titleLabel.apply(.greyS16R400)
    }
}
