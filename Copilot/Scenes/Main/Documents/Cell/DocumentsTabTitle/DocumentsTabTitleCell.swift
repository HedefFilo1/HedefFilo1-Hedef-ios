//
//  DocumentsTabTitleCell.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import UIKit

protocol DocumentsTabTitleCellDelegate: AnyObject {
    func didTabBack()
}

class DocumentsTabTitleCell: UICollectionViewCell, Reusable {

    weak var delegate: DocumentsTabTitleCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        titleLabel.apply(.blackS14B700)
        backImageView.image = backImageView.image?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = .black
    }

    @IBAction func didTabBack() {
        delegate?.didTabBack()
    }
}
