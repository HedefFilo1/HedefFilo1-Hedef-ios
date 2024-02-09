//
//  JustYellowWarningCell.swift
//  Copilot
//
//  Created by Jamal on 2/9/24.
//

import UIKit

class JustYellowWarningCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        label.apply(.greyS14R400)
    }

}
