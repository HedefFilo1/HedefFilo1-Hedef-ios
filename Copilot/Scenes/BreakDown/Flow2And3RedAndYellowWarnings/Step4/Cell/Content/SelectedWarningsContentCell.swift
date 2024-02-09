//
//  SelectedWarningsContentCell.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import UIKit

protocol SelectedWarningsContentCellDelegate: AnyObject {
    func didTapShowLocation()
}

class SelectedWarningsContentCell: UICollectionViewCell, Reusable {
    
    weak var delegate: SelectedWarningsContentCellDelegate?
    
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var getWellLabel: UILabel!
    @IBOutlet weak var donotStartLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var showLocationLabel: UILabel!

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
        locationLabel.apply(.greyS14R400)
        showLocationLabel.apply(.themeS12B700)
    }
    
    func setTexts() {
        getWellLabel.text = Strings.getWellSoon
        donotStartLabel.text = Strings.donotStartVehicle
        descriptionLabel.text = Strings.towTruckSendingDescription
        showLocationLabel.text = Strings.showLocation
    }
    
    @IBAction func didTapShowLocation() {
        delegate?.didTapShowLocation()
    }
}
