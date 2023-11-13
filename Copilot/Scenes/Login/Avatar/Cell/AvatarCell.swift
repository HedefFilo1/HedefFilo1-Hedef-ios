//
//  AvatarCell.swift
//  Copilot
//
//  Created by Jamal on 11/13/23.
//

import UIKit

class AvatarCell: UICollectionViewCell, Reusable {
    
    var item: Avatar? {
        didSet {
            if let image = item?.image {
                imageView.image = UIImage(named: image)
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var radioBox: CPRadioBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
    }
}
