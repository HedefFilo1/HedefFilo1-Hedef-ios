//
//  ServicesItemCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

class ProccessRequestsItemCell: UICollectionViewCell, Reusable {

    var item: ProccessRequestsItem? {
        didSet {
            nameLabel.text = item?.title
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyles()
    }

    func applyStyles() {
        layer.cornerRadius = 10
        backgroundColor = .disabled
        nameLabel.apply(.blackS16B700)
        dateLabel.apply(.greyS14R400)
    }
}