//
//  MaintenanceCell.swift
//  Copilot
//
//  Created by Jamal on 1/30/24.
//

import UIKit

protocol MaintenanceCellDelegate: AnyObject {
    func didTapRandevu()
}

class MaintenanceCell: UICollectionViewCell, Reusable {
    
    weak var delegate: MaintenanceCellDelegate?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var randevuButton: CPLightButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setTexts()
        
    }
    
    func setup() {
        titleLabel?.apply(.blackS16B700)
        descriptionLabel?.apply(.blackS14R400)
    }
    
    func setTexts() {
        titleLabel?.text = Strings.noMaintenanceAppointment
        descriptionLabel?.text = Strings.makeAnAppointment
        randevuButton.setTitle(Strings.createMaintenanceAppointment, for: .normal)
    }
    
    @IBAction func didTapRandevu() {
        delegate?.didTapRandevu()
    }
}
