//
//  RequestListCountCell.swift
//  Copilot
//
//  Created by Jamal on 10/30/24.
//

import UIKit

class RequestListCountCell: UICollectionViewCell, Reusable {
    var itemsCount = "" {
        didSet {
            countLabel.text = "\(itemsCount)"
        }
    }
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countLabel.apply(.greyS12R400)
    }

}
