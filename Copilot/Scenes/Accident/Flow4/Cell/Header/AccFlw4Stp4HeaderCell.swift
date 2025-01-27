//
//  AccFlw4Stp4HeaderCell.swift
//  Copilot
//
//  Created by Jamal on 2/22/24.
//

import UIKit

class AccFlw4Stp4HeaderCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var callLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setTexts()
        
    }
    
    func setup() {
        titleLabel.apply(.blackS20B700)
        descriptionLabel.apply(.greyS12R400)
        callView.layer.cornerRadius = 10
        callView.backgroundColor = .theme
        callLabel.apply(.whiteS16B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.zabit.title")
        descriptionLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.zabit.description")
        callLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.zabit.call.emergency.button")
    }
    
    @IBAction func didTapCall() {
        guard let url = URL(string: CodeStrings.call112) else {
            return
        }
        UIApplication.shared.open(url)
    }
}
