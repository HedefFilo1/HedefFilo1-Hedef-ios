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
        titleLabel?.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.engine.question")
        yesButton.setTitle(App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.engine.yes.button"), for: .normal)
        noButton.setTitle(App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.engine.no.button"), for: .normal)
    }
    
    @IBAction func didTapYes() {
        delegate?.didTapYes()
    }
    
    @IBAction func didTapNo() {
        delegate?.didTapNo()
    }
}
