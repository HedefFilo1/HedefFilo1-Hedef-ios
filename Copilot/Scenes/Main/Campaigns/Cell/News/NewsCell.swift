//
//  CampaignCell.swift
//  Copilot
//
//  Created by Jamal on 11/6/23.
//

import UIKit

class NewsCell: UICollectionViewCell, Reusable {
 
    var item: Campaign? {
        didSet {
            imageView.loadImageFrom(url: item?.imageFile)
            titleLabel.text = item?.title
            textLabel.text = item?.content
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var continueLabel: UILabel!
    
    weak var delegate: CampaignsTabCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        backgroundColor = .white
        imageView.layer.cornerRadius = 12
        titleLabel.apply(.blackS16B700)
        textLabel.apply(.greyS12R400)
        continueLabel.apply(.themeS12B700)
    }
    
    @IBAction func didTapContiune() {
        if let item = item {
            delegate?.didSelectItem(campaign: item)
        }
    }
}
