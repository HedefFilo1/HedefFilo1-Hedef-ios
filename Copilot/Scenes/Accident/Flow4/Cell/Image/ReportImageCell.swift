//
//  ReportImageCell.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import UIKit

protocol ReportImageCellDelegate: AnyObject {
    func didTapDelete(at index: Int)
}

class ReportImageCell: UICollectionViewCell, Reusable {
    weak var delegate: ReportImageCellDelegate?
    var index = 0
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

    @IBAction func didTapDelete() {
        delegate?.didTapDelete(at: index)
    }
}
