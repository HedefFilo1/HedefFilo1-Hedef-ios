//
//  HGSEmptyCell.swift
//  Copilot
//
//  Created by Jamal on 12/11/23.
//

import UIKit

class HGSEmptyCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.apply(.blackS14R400)
        label.text = App.getString(key: CodeStrings.hgsEmpty) ?? Strings.hgsEmpty
    }

}
