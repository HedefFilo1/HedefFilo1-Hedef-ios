//
//  TireInfoCell.swift
//  Copilot
//
//  Created by Jamal on 10/11/23.
//

import UIKit

class TireInfoCell: UICollectionViewCell, Reusable {
    
    var tire: Tire? {
        didSet {
            nameLabel.text = tire?.supplierName
            addressLabel.text = tire?.supplierAddress
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS20B700)
        imageContainer.layer.cornerRadius = 10
        imageContainer.backgroundColor = UIColor.secondRed
        nameLabel.apply(.blackS16B700)
        addressLabel.apply(.greyS12M500)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.homepage.tire.information.storage")
    }
}
