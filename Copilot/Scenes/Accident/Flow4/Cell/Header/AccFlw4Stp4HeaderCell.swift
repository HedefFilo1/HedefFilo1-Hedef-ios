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
        titleLabel.text = Strings.keepReport
        descriptionLabel.text = Strings.cannotRichAgreemntDescription
        callLabel.text = Strings.call112
    }
    
    @IBAction func didTapCall() {
        
    }
}
