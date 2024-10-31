//
//  RequestListItemCell.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import UIKit

class RequestListItemCell: UICollectionViewCell, Reusable {
    
    var item: Task? {
        didSet {
            titleLabel.text = item?.subjectResult
            if let text =  item?.statusTextResult {
                statusLabel.text = text
                statusView.backgroundColor = item?.status.color
            } else {
                statusLabel.text = ""
                statusView.backgroundColor = .clear
            }
            dateLabel.text = item?.displayDate
        }
    }
    
    var request: Demand? {
        didSet {
            titleLabel.text = request?.recordTypeResult
            if let text =  request?.statusTextResult {
                statusLabel.text = text
                statusView.backgroundColor = request?.statusEnum.color
            } else {
                statusLabel.text = ""
                statusView.backgroundColor = .clear
            }
            dateLabel.text = request?.displayDate
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.disabled.cgColor
        titleLabel.apply(.blackS16R400)
        statusView.layer.cornerRadius = 10
        statusLabel.apply(.custom(.white, .regular, 12))
        dateLabel.apply(.blackS14R400)
    }

}
