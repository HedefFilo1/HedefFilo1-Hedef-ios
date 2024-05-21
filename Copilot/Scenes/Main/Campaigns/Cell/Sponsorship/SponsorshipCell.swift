//
//  CampaignCell.swift
//  Copilot
//
//  Created by Jamal on 11/6/23.
//

import UIKit

class SponsorshipCell: UICollectionViewCell, Reusable {
    
    var item: Campaign? {
        didSet {
            imageView.loadImageFrom(url: item?.imageFile)
            titleLabel.text = item?.title
            textLabel.text = item?.content
        }
    }
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    weak var delegate: CampaignsTabCellDelegate?
    
    var isRightToLeft = false {
        didSet {
            if isRightToLeft, let imageView = stackView.subviews.first {
                stackView.removeArrangedSubview(imageView)
                stackView.setNeedsLayout()
                stackView.layoutIfNeeded()
                stackView.addArrangedSubview(imageView)
                stackView.setNeedsLayout()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        backgroundColor = .white
        imageView.layer.cornerRadius = 12
        titleLabel.apply(.blackS16B700)
        textLabel.apply(.greyS12R400)
    }
}
