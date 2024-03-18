//
//  RequestListItemCell.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import UIKit

class RequestListItemCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.disabled.cgColor
        titleLabel.apply(.blackS16R400)
        statusView.layer.cornerRadius = 10
        statusLabel.apply(.custom(.white, .regular, 12))
    }

}
