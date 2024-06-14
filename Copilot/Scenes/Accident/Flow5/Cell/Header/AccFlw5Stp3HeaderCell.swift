//
//  AccFlw4Stp4HeaderCell.swift
//  Copilot
//
//  Created by Jamal on 2/22/24.
//

import UIKit

protocol AccFlw5Stp3HeaderCellDelegate: AnyObject {
    func didTapGuilde()
}

class AccFlw5Stp3HeaderCell: UICollectionViewCell, Reusable {
    
    weak var delegate: AccFlw5Stp3HeaderCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var guidLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setTexts()
        
    }
    
    func setup() {
        titleLabel.apply(.blackS20B700)
        descriptionLabel.apply(.greyS12R400)
        guidLabel.apply(.themeS14B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.declaration.notification.title")
        descriptionLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.declaration.notification.description")
//        guidLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.go.accident.guide.button")
        
        guidLabel.text = App.getString(key: "copilotapp.accidentdamage.declaration.form.example.button")
    }
    
    @IBAction func didTapGuide() {
        delegate?.didTapGuilde()
    }
}
