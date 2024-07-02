//
//  StandingItemCell.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import UIKit

class StandingItemCell: UICollectionViewCell, Reusable {
    
    var title: String = ""
    var point: Int = 0 {
        didSet {
            
            let strArray = title.components(separatedBy: "(")
            let firstText = strArray.first ?? ""
           
            var secondText = ""
            if strArray.count == 2 {
                secondText = strArray[1].replacingOccurrences(of: "{point}", with: "\(point)")
            }
            
            let first = AttributedText(text: "\(firstText)", type: .blackS14M500)
            let second = AttributedText(text: " (\(secondText)", type: .blackS14R400)
            
            titleLabel.attributedText = AttributedText.createString(texts: [first, second])
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
