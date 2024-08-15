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
                statusLabel.text = item?.statusTextResult
                statusView.backgroundColor = item?.status.color
            } else {
                statusLabel.text = ""
                statusView.backgroundColor = .clear
            }
            
        }
    }
    
    var request: Demand? {
        didSet {
            titleLabel.text = request?.recordType
            if let text =  request?.statusTextResult {
                statusLabel.text = text
                statusView.backgroundColor = request?.statusEnum.color
            } else {
                statusLabel.text = ""
                statusView.backgroundColor = .clear
            }
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
