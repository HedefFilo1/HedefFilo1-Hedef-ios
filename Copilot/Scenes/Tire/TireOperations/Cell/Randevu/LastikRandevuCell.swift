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
                statusLabel.text = Strings.approved
            } else {
                statusView.backgroundColor = .appYellow
                statusLabel.text = Strings.waitingToApprove
            }
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
    }
    
    @IBAction func didTapEdit() {
        delegate?.didTapEdit()
    }

}
