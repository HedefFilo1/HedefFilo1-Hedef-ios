//
//  WarningGuideCell.swift
//  Copilot
//
//  Created by Jamal on 5/23/24.
//

import UIKit

class WarningGuideCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        titleLabel.apply(.blackS12R400)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.disabled.cgColor
    }
}
 
