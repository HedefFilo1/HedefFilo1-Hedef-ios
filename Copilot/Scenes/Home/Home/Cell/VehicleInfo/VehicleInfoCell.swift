//
//  VehicleInfoCell.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import UIKit

protocol VehicleInfoCellDelegate: AnyObject {
    func didTapKmUsed()
}

class VehicleInfoCell: UICollectionViewCell, Reusable {
    
    weak var delegate: VehicleInfoCellDelegate?
    
    var vehicle: Vehicle? {
        didSet {
            
            modelLabel.text = vehicle?.model ?? "model"
            if let plate = vehicle?.plateNumber {
                modelLabel.text = plate
            }
            nameLabel.text = vehicle?.make ?? "Brand"
            let rent = vehicle?.leaseDuration ?? "0"
            rentValueLabel.text = rent + " " + Strings.months
            let distance = vehicle?.leaseDistanceLimit ?? "0"
            limitValueLabel.text = distance + " " + Strings.ckm
            let last = vehicle?.lastKnownDistance ?? "0"
            usedValueLabel.text = last + " " + Strings.ckm
            
            if let name = Persistence.avatarName {
                imageView.image = UIImage(named: name)
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var rentValueLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var limitValueLabel: UILabel!
    @IBOutlet weak var usedLabel: UILabel!
    @IBOutlet weak var usedValueLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
    }

    private func applyStyles() {
        titleLabel.apply(.whiteS20B700)
        containerView.layer.cornerRadius = 15
        containerView.backgroundColor = .white
        containerView.boxShadow(xValue: 0, yValue: 20, radius: 35, color: .black, opacity: 0.1)
        modelLabel.apply(.blackS16B700)
        nameLabel.apply(.greyS12R400)
        rentLabel.apply(.greyS12R400)
        rentValueLabel.apply(.blackS12B700)
        limitLabel.apply(.greyS12R400)
        limitValueLabel.apply(.blackS12B700)
        usedLabel.apply(.greyS12R400)
        usedValueLabel.apply(.blackS12B700)
       
        changeButton.layer.cornerRadius = 16
        changeButton.backgroundColor = .appRed
        changeButton.apply(.whiteS12B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.vehicleInformation
        rentLabel.text = Strings.rentalPeriod
        limitLabel.text = Strings.kmLimit
        usedLabel.text = Strings.kmUsed
        changeButton.setTitle(Strings.makeChange, for: .normal)
    }
    
    @IBAction func didTapChangeButton() {
        delegate?.didTapKmUsed()
    }
}
