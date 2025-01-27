//
//  PastServiceDetailCell.swift
//  Copilot
//
//  Created by Jamal on 4/5/24.
//

import UIKit

class PastServiceDetailCell: UICollectionViewCell, Reusable {
    
    var item: PastService? {
        didSet {
            dateLabel.text = item?.displayDate
            timeLabel.text = item?.time
            serviceLabel.text = item?.serviceName
            addressLabel.text = item?.address
            phoneLabel.text = item?.supplierPhone
            let kmc = item?.km ?? 0
            kmLabel.text = "\(kmc)"
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var operationTitleLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var kmTitleLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyles()
        setTexts()
    }

    func applyStyles() {
        
        dateLabel.apply(.blackS16B700)
        timeLabel.apply(.greyS16B700)
        serviceLabel.apply(.blackS14B700)
        addressTitleLabel.apply(.blackS14B700)
        addressLabel.apply(.greyS12R400)
        phoneLabel.apply(.greyS12R400)
        operationTitleLabel.apply(.blackS14B700)
        operationLabel.apply(.greyS12R400)
        
        kmTitleLabel.apply(.blackS14B700)
        kmLabel.apply(.greyS12R400)
        
        statusTitleLabel.apply(.blackS14B700)
        statusLabel.apply(.blackS14B700)
    }
    
    func setTexts() {
        addressTitleLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.maintenance.detail.address")
        operationTitleLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.maintenance.detail.process")
        kmTitleLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.maintenance.detail.km.info")
        statusTitleLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.maintenance.detail.status")
    }
}
