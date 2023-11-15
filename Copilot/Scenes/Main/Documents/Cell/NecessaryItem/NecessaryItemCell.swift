//
//  NecessaryItemCellCell.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import UIKit

class NecessaryItemCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS14M500)
    }
}
