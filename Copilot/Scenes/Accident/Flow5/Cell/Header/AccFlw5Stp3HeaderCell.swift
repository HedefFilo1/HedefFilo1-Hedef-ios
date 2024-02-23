//
//  AccFlw4Stp4HeaderCell.swift
//  Copilot
//
//  Created by Jamal on 2/22/24.
//

import UIKit

class AccFlw5Stp3HeaderCell: UICollectionViewCell, Reusable {
    
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
        titleLabel.text = Strings.declarationNotice
        descriptionLabel.text = Strings.declarationNoticeDescription
        guidLabel.text = Strings.goToAccidentGuide
    }
    
    @IBAction func didTapGuide() {
        
    }
}
