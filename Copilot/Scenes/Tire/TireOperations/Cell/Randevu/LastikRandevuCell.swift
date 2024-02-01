//
//  LastikRandevuCell.swift
//  Copilot
//
//  Created by Jamal on 1/17/24.
//

import UIKit

protocol LastikRandevuCellDelegate: AnyObject {
    func didTapEdit()
}

class LastikRandevuCell: UICollectionViewCell, Reusable {
    
    var appointment: Case? {
        didSet {
            dateLabel.text = appointment?.displayDateWithYear
            serviceNameLabel.text = appointment?.supplierName
            addressLabel.text = appointment?.address
            phoneLabel.text = appointment?.supplierPhone
            typeLabel.text = appointment?.title
            let type = appointment?.appointmentStatus ?? .none
            if type == .appointmentApproved {
                statusView.backgroundColor = .textSuccess
                statusLabel.text = Strings.randevuApproved
            } else {
                statusView.backgroundColor = .appYellow
                statusLabel.text = Strings.waitingToApprove
            }
        }
    }
    
    var tire: Tire? {
        didSet {
            tireServiceLabel.text = tire?.supplierName
            tireInfoLabel.text = tire?.supplierAddress
        }
    }
    
    weak var delegate: LastikRandevuCellDelegate?
    @IBOutlet weak var randevuTitleLabel: UILabel!
    @IBOutlet weak var randevuView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var editLabel: UILabel!
    
    @IBOutlet weak var tireTitleLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var tireServiceLabel: UILabel!
    @IBOutlet weak var tireInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyles()
    }

    func applyStyles() {
        randevuTitleLabel.apply(.blackS20B700)
        randevuView.layer.cornerRadius = 10
        randevuView.layer.borderColor = UIColor.borderColor.cgColor
        randevuView.layer.borderWidth = 1
        dateLabel.apply(.blackS14R400)
        typeLabel.apply(.greyS14B700)
        serviceNameLabel.apply(.blackS16B700)
        addressLabel.apply(.greyS14R400)
        phoneLabel.apply(.blackS12R400)
        
        statusView.backgroundColor = .appYellow
        statusView.layer.cornerRadius = 12
        statusLabel.apply(.whiteS12B700)
        editLabel.apply(.whiteS12B700)
        editLabel.textColor = .theme
        
        tireTitleLabel.apply(.blackS20B700)
        imageContainer.layer.cornerRadius = 10
        tireServiceLabel.apply(.blackS16B700)
        tireInfoLabel.apply(.greyS12M500)
    }
    
    @IBAction func didTapEdit() {
        delegate?.didTapEdit()
    }

}
