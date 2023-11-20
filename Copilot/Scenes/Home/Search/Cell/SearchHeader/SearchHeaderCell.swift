//
//  SearchHeaderCell.swift
//  Copilot
//
//  Created by Jamal on 11/17/23.
//

import UIKit

class SearchHeaderCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.apply(.blackS14B700)
    }

}
