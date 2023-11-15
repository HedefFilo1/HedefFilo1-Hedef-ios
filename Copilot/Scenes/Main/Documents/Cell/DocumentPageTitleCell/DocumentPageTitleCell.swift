//
//  DocumentPageTitleCell.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import UIKit

class DocumentPageTitleCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.apply(.greyS14R400)
        titleLabel.text = Strings.documentsSavedInCopilot
    }

}
