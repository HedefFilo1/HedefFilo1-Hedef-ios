//
//  VehicleInfoButtonsCell.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import UIKit

class VehicleInfoButtonsCell: UICollectionViewCell, Reusable {
    
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
        
    }
    
    @IBAction func didTapRequests() {
        
    }
}
