//
//  FilterCell.swift
//  Copilot
//
//  Created by Jamal on 10/30/23.
//

import UIKit

class FilterCell: UICollectionViewCell, Reusable {
    
    var item: Filter? {
        didSet {
            titleLabel.text = item?.tilte
            checkBox.isSelected = item?.selected ?? false
        }
    }
    
    @IBOutlet weak var checkBox: CPCheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS16R400)
    }
}
