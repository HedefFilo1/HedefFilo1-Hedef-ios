//
//  TireInfoCell.swift
//  Copilot
//
//  Created by Jamal on 10/11/23.
//

import UIKit

class TireInfoCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS20B700)
        imageContainer.layer.cornerRadius = 10
        imageContainer.backgroundColor = UIColor.secondRed
        serviceLabel.apply(.blackS16B700)
        serviceNameLabel.apply(.greyS12M500)
    }
    
    func setTexts() {
        titleLabel.text = Strings.tireInformation
    }
}
