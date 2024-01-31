//
//  BreakDownCell.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import UIKit

protocol BreakDownCellDelegate: AnyObject {
    func didTapYes()
    func didTapNo()
}

class BreakDownCell: UICollectionViewCell, Reusable {
    
    weak var delegate: BreakDownCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yesButton: CPLightButton!
    @IBOutlet weak var noButton: CPLightButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setTexts()
        
    }
    
    func setup() {
        titleLabel?.apply(.blackS20B700)
    }
    
    func setTexts() {
        titleLabel?.text = Strings.isVehicleEngineWorking
        yesButton.setTitle(Strings.yesItWorks, for: .normal)
        noButton.setTitle(Strings.noItDoesntWork, for: .normal)
    }
    
    @IBAction func didTapYes() {
        delegate?.didTapYes()
    }
    
    @IBAction func didTapNo() {
        delegate?.didTapNo()
    }
}
