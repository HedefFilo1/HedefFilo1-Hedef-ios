//
//  SelectedWarningsContentCell.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import UIKit

class SelectedWarningsContentCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var getWellLabel: UILabel!
    @IBOutlet weak var donotStartLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI() {
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        headView.layer.cornerRadius = 10
        headView.layer.borderWidth = 1
        headView.layer.borderColor = UIColor.borderColor.cgColor
        
        getWellLabel.apply(.blackS20B700)
        donotStartLabel.apply(.themeS14B700)
        descriptionLabel.apply(.greyS16R400)
    }
    
    func setTexts() {
        getWellLabel.text = Strings.getWellSoon
        donotStartLabel.text = Strings.donotStartVehicle
        descriptionLabel.text = Strings.towTruckSendingDescription
    }
  
}
