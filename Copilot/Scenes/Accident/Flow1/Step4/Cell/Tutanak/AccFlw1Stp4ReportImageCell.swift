//
//  AccFlw1Stp4ReportImageCell.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import UIKit

protocol AccFlw1Stp4ReportImageCellDelegate: AnyObject {
    func didTapDelete(index: Int)
}

class AccFlw1Stp4ReportImageCell: UICollectionViewCell, Reusable {
    
    weak var delegate: AccFlw1Stp4ReportImageCellDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteView: UIView!
    
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        
    }
    
    func setup() {
        deleteView.layer.cornerRadius = 5
        deleteView.layer.borderWidth = 1
        deleteView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
    }

    @IBAction func didTapDelete() {
        delegate?.didTapDelete(index: index)
    }
}
