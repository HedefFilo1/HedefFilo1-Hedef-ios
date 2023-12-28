//
//  VehicleServicesItemCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

class VehicleServicesItemCell: UICollectionViewCell, Reusable {

    var item: Supplier? {
        didSet {
            nameLabel.text = item?.name
            addressLabel.text = item?.address
            numberLabel.text = ""
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyles()
    }

    func applyStyles() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        nameLabel.apply(.blackS16B700)
        numberLabel.apply(.blackS12R400)
        addressLabel.apply(.greyS14R400)
        dateLabel.apply(.greyS12R400)
        iconView.layer.cornerRadius = 5
        iconView.layer.borderWidth = 1
        iconView.layer.borderColor = UIColor.theme.cgColor
    }
    
}