//
//  HGSCell.swift
//  Copilot
//
//  Created by Jamal on 11/24/23.
//

import UIKit

class HGSCell: UICollectionViewCell, Reusable {
    
    weak var delegate: DocumentCellDelegate?
    @IBOutlet weak var enteranceLabel: UILabel!
    @IBOutlet weak var exitLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        applyStyles()
        setEntranceLabel(text: "İstanbul")
        setExitLabel(text: "İzmit")
    }
    
    private func applyStyles() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        dateLabel.apply(.greyS14R400)
        amountLabel.apply(.themeS12B700)
        detailLabel.apply(.themeS12B700)
    }
    
    func setEntranceLabel(text: String) {
        let entrance = [AttributedText(text: Strings.entrance, type: .blackS16R400),
                        AttributedText(text: text, type: .blackS16B700)]
        enteranceLabel.attributedText = AttributedText.createString(texts: entrance)
    }
    
    func setExitLabel(text: String) {
        let exit = [AttributedText(text: Strings.exit, type: .blackS16R400),
                        AttributedText(text: text, type: .blackS16B700)]
        exitLabel.attributedText = AttributedText.createString(texts: exit)
    }
}
