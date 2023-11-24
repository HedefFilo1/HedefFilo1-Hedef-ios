//
//  VehicleInfoButtonsCell.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import UIKit

protocol VehicleInfoButtonsCellDelegate: AnyObject {
    func didTapGuide()
    func didTapRequests()
}

class VehicleInfoButtonsCell: UICollectionViewCell, Reusable {
    
    weak var delegate: VehicleInfoButtonsCellDelegate?
    @IBOutlet weak var goLabel: UILabel!
    @IBOutlet weak var goButton: CPButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
        goButton.isEnabled = true
    }
    
    private func applyStyles() {
        goLabel.apply(.themeS14B700)
        
    }
    
    func setTexts() {
        goLabel.text = Strings.goToVehicleGuide
        goButton.setTitle(Strings.goToVehicleRequests, for: .normal)
    }
    
    @IBAction func didTapGuide() {
        delegate?.didTapGuide()
    }
    
    @IBAction func didTapRequests() {
        delegate?.didTapRequests()
    }
}
