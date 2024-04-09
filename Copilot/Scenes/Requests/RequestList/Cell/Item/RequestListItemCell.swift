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
            titleLabel.text = item?.subject
            statusLabel.text = item?.status.text
            statusView.backgroundColor = item?.status.color
        }
    }
    
    var request: Demand? {
        didSet {
            titleLabel.text = request?.recordType
            statusLabel.text = request?.status
            statusView.backgroundColor = request?.statusEnum.color
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
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
    }

}
