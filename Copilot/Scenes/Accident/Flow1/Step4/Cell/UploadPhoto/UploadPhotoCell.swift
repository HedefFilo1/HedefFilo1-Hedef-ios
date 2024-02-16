//
//  UploadPhotoCell.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import UIKit

class UploadPhotoCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.apply(.themeS12B700)
    }

}
