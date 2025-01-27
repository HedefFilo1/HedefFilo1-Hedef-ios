//
//  WarningLightsHeaderCell.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import UIKit

class WarningLightsHeaderCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var selectLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setTexts()
        
    }
    
    func setup() {
        descriptionLabel.apply(.greyS12R400)
        selectLabel.apply(.blackS20B700)
    }
    
    func setTexts() {
        descriptionLabel.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.description")
        selectLabel.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.warning.light.go.warning.light.title")
    }
}
