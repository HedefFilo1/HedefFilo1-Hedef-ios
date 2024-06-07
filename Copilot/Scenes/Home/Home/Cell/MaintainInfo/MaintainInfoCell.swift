//
//  MaintainInfoCell.swift
//  Copilot
//
//  Created by Jamal on 10/11/23.
//

import UIKit

class MaintainInfoCell: UICollectionViewCell, Reusable {
    
    var last: MaintenanceLast? {
        didSet {
            serviceLabel.text = last?.serviceName
            partLabel.text = last?.address
            dateLabel.text = last?.displayDate
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var partLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
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
        partLabel.apply(.blackS16B700)
        serviceLabel.apply(.greyS12M500)
        dateLabel.apply(.blackS12M500)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.homepage.last.maintenance.information")
        partLabel.text = App.getString(key: "copilotapp.home.periodic.maintenance")
    }
}
