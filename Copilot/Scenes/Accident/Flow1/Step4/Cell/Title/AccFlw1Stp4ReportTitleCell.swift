//
//  AccFlw1Stp4ReportTitleCell.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import UIKit

class AccFlw1Stp4ReportTitleCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.apply(.blackS14B700)
    }

}
