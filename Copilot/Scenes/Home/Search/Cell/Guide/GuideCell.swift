//
//  GuideCell.swift
//  Copilot
//
//  Created by Jamal on 11/17/23.
//

import UIKit

protocol GuideCellDelegate: AnyObject {
    func didTapGo()
}

class GuideCell: UICollectionViewCell, Reusable {
    
    weak var delegate: GuideCellDelegate?
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var goLabel: UILabel!
    @IBOutlet weak var goImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS16B700)
        descriptionLabel.apply(.greyS14R400)
        goLabel.apply(.greyS12B700)
        goImageView.image = goImageView.image?.withRenderingMode(.alwaysTemplate)
        goImageView.tintColor = .textGrey
    }
    
    @IBAction func didTapGo() {
        delegate?.didTapGo()
    }
}
