//
//  AccFlw1Stp4ReportImageCell.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import UIKit

class AccFlw1Stp4ReportImageCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        
    }
    
    func setup() {
        deleteView.layer.cornerRadius = 5
        deleteView.layer.borderWidth = 1
        deleteView.layer.borderColor = UIColor.black.cgColor
    }

}
