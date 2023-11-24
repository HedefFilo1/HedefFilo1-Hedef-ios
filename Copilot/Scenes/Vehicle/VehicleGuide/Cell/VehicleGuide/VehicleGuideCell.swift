//
//  VehicleGuideCell.swift
//  Copilot
//
//  Created by Jamal on 11/24/23.
//

import UIKit

class VehicleGuideCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        label.apply(.greyS14R400)
    }

}
