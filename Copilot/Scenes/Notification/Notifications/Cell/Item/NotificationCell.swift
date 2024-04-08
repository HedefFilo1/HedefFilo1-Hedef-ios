//
//  NotificationCell.swift
//  Copilot
//
//  Created by Jamal on 3/27/24.
//

import UIKit

class NotificationCell: UITableViewCell, Reusable {
    
    var item: UserNotification? {
        didSet {
            unreadView.isHidden = item?.isRead ?? false
            notifLabel.text = item?.body
            timeLabel.text = item?.displayDate
            iconImageView.image = item?.type.image
        }
    }
    
    @IBOutlet weak var unreadView: UIView!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var notifLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        applyStyles()
    }
    
    func applyStyles() {
        unreadView.layer.cornerRadius = 3
        iconView.layer.cornerRadius = 56/2
        iconView.layer.borderWidth = 1
        iconView.layer.borderColor = UIColor.lightRed.cgColor
        notifLabel.apply(.blackS14R400)
        timeLabel.apply(.greyS12R400)
    }
    
}
