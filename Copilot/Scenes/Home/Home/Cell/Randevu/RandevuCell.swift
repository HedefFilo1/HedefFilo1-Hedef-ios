//
//  RandevuCell.swift
//  Copilot
//
//  Created by Jamal on 10/11/23.
//

import UIKit

class RandevuCell: UICollectionViewCell, Reusable {
    
    var appointment: Case? {
        didSet {
            if let appointment = appointment {
                randevuLabel.text = appointment.supplierName
                dateLabel.text = appointment.appointmentDate
            }
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var randevuLabel: UILabel!
    
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
        imageContainer.layer.cornerRadius = 10
        dateLabel.apply(.blackS16B700)
        randevuLabel .apply(.greyS12M500)
    }
    
    func setTexts() {
        titleLabel.text = Strings.upcomingAppointment
    }
}
