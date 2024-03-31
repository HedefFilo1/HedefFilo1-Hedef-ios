//
//  ServicesItemCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

class PastServicesItemCell: UICollectionViewCell, Reusable {

    var item: PastService? {
        didSet {
            dateLabel.text = item?.displayDate
            timeLabel.text = item?.time
            serviceLabel.text = item?.serviceName
            typeLabel.text = item?.type
            addressLabel.text = item?.address
            phoneLabel.text = item?.supplierPhone
            
            let type = item?.appointmentStatusEnum ?? .none
            if type == .appointmentApproved {
                statusView.backgroundColor = .textSuccess
                statusLabel.text = Strings.approved
            } else {
                statusView.backgroundColor = .appYellow
                statusLabel.text = Strings.waitingToApprove
            }
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyles()
    }

    func applyStyles() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        dateLabel.apply(.blackS16B700)
        timeLabel.apply(.greyS16B700)
        serviceLabel.apply(.blackS14B700)
        typeLabel.apply(.greyS12B700)
        addressLabel.apply(.greyS14R400)
        phoneLabel.apply(.greyS12R400)
        statusView.layer.cornerRadius = 10
        statusLabel.apply(.whiteS12B700)
    }
}
