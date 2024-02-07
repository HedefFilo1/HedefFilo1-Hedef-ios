//
//  WarningItemCell.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import UIKit

class WarningItemCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
    }
}
