//
//  SelectedWarningItemCell.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import UIKit

class SelectedWarningItemCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.apply(.blackS18B700)
    }

}
