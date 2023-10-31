//
//  StandingItemCell.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import UIKit

class StandingItemCell: UICollectionViewCell, Reusable {
    
    var point: Int = 0 {
        didSet {
            let first = titleLabel.text ?? ""
            let second = "(\(point) \(Strings.point))"
            let main = AttributedText(text: "\(first) \(second)", type: .blackS14M500)
            let point = AttributedText(text: "\(second)", type: .blackS14R400)
            titleLabel.attributedText = AttributedText.createMultiplePartString(mainText: main, texts: [point])
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS14M500)
    }
}
