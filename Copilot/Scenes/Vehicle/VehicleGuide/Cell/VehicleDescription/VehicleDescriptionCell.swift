//
//  VehicleDescriptionCell.swift
//  Copilot
//
//  Created by Jamal on 11/24/23.
//

import UIKit

class VehicleDescriptionCell: UICollectionViewCell, Reusable {
    
    weak var delegate: DocumentCellDelegate?
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var bodyLabels: [UILabel]!
    @IBOutlet var subtitleLabels: [UILabel]!
    @IBOutlet var pinkViews: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        
        for label in titleLabels {
            label.apply(.blackS18B700)
        }
        for label in bodyLabels {
            label.apply(.greyS14R400)
        }
        for label in subtitleLabels {
            label.apply(.blackS12B700)
        }
        for view in pinkViews {
            view.layer.cornerRadius = 36
        }
    }
}
