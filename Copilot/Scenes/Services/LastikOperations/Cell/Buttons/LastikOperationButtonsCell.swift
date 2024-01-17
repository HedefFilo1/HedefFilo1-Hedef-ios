//
//  LastikOperationButtonsCell.swift
//  Copilot
//
//  Created by Jamal on 1/17/24.
//

import UIKit

protocol LastikOperationButtonsCellDelegate: AnyObject {
    func goToRequestNewLastik()
    func goToLastikRandevu()
    func didTapChange()
}

class LastikOperationButtonsCell: UICollectionViewCell, Reusable {
    
    weak var delegate: LastikOperationButtonsCellDelegate?
    @IBOutlet weak var requestNewButton: CPLightButton!
    @IBOutlet weak var randevuButton: CPLightButton!
    @IBOutlet weak var changeButton: CPLightButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        requestNewButton.setTitle(Strings.requestNewTire, for: .normal)
        randevuButton.setTitle(Strings.tireDamageAppointment, for: .normal)
        changeButton.setTitle(Strings.tireChangeAppointment, for: .normal)
    }
    
    @IBAction func didTapRequestNew() {
        delegate?.goToRequestNewLastik()
    }
    
    @IBAction func didTapRandevu() {
        delegate?.goToLastikRandevu()
    }
    
    @IBAction func didTapChange() {
        delegate?.didTapChange()
    }
}
