//
//  UploadCell.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import UIKit

class UploadCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var uploadButton: CPLightButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        uploadLabel.apply(.themeS16B700)
        uploadImageView.image = uploadImageView.image?.withRenderingMode(.alwaysTemplate)
        uploadImageView.tintColor = .theme
        uploadButton.backgroundColor = .clear
        uploadLabel.text = Strings.uploadDocument
    }
}
