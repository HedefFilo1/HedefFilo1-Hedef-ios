//
//  MaintainInfoCell.swift
//  Copilot
//
//  Created by Jamal on 10/11/23.
//

import UIKit

class MaintainInfoCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var oilLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
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
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.borderColor.cgColor
        oilLabel.apply(.blackS16B700)
        secondLabel.apply(.greyS12M500)
        dateLabel.apply(.blackS12M500)
    }
    
    func setTexts() {
        titleLabel.text = Strings.tireInformation
    }
}
