//
//  CampaignsTitleCell.swift
//  Copilot
//
//  Created by Jamal on 11/7/23.
//

import UIKit

class CampaignsTitleCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.apply(.greyS14R400)
    }
}
