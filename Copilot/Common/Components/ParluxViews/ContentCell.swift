//
//  ContentCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

class ContentCell: UICollectionViewCell, Reusable {

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        container.backgroundColor = .white
        container.layer.cornerRadius = 40
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
    }

}
