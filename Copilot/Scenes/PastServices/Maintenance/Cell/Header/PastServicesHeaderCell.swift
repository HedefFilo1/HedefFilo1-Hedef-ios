//
//  PastServicesHeaderCell.swift
//  Copilot
//
//  Created by Jamal on 3/29/24.
//

import UIKit

class PastServicesHeaderCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.apply(.blackS18B700)
        descriptionLabel.apply(.greyS14R400)
    }

}
