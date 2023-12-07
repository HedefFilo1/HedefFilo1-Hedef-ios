//
//  VehicleInfoCell.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import UIKit

class VehicleCell: UICollectionViewCell, Reusable {
    
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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var rentValueLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var limitValueLabel: UILabel!
    @IBOutlet weak var usedLabel: UILabel!
    @IBOutlet weak var usedValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
    }

    private func applyStyles() {
        modelLabel.apply(.blackS16B700)
        nameLabel.apply(.greyS12R400)
        infoLabel.apply(.blackS14B700)
        rentLabel.apply(.greyS12R400)
        rentValueLabel.apply(.blackS12B700)
        limitLabel.apply(.greyS12R400)
        limitValueLabel.apply(.blackS12B700)
        usedLabel.apply(.greyS12R400)
        usedValueLabel.apply(.blackS12B700)
    }
    
    func setTexts() {
        infoLabel.text = Strings.vehicleInfoDetails
        rentLabel.text = Strings.rentalPeriod
        limitLabel.text = Strings.kmLimit
        usedLabel.text = Strings.vehicleUsedKm
    }
    
}
