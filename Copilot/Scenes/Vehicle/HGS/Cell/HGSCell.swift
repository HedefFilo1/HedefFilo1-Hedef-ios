//
//  HGSCell.swift
//  Copilot
//
//  Created by Jamal on 11/24/23.
//

import UIKit

protocol HGSCellDelegate: AnyObject {
    func didTapDetail(transition: Transition)
}

class HGSCell: UICollectionViewCell, Reusable {
    
    var item: Transition? {
        didSet {
            if let item = item {
                setEntranceLabel(text: item.entryPoint ?? "")
                setExitLabel(text: item.exitPoint)
                dateLabel.text = item.exitDisplayDate
                amountLabel.text = item.displayToll
            }
        }
    }
    
    weak var delegate: HGSCellDelegate?
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
        setEntranceLabel(text: " İstanbul")
        setExitLabel(text: " İzmit")
    }
    
    private func applyStyles() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        dateLabel.apply(.greyS14R400)
        amountLabel.apply(.themeS12B700)
        detailLabel.apply(.themeS12B700)
        detailLabel.text = App.getString(key: "copilotapp.hgstransition.detail.information.button")
    }
    
    func setEntranceLabel(text: String) {
        let first = App.getString(key: "copilotapp.hgstransition.enter") ?? ""
        let entrance = [AttributedText(text: "\(first): ", type: .blackS16R400),
                        AttributedText(text: text, type: .blackS16B700)]
        enteranceLabel.attributedText = AttributedText.createString(texts: entrance)
    }
    
    func setExitLabel(text: String) {
        let first = App.getString(key: "copilotapp.hgstransition.exit") ?? ""
        let exit = [AttributedText(text: "\(first): ", type: .blackS16R400),
                        AttributedText(text: text, type: .blackS16B700)]
        exitLabel.attributedText = AttributedText.createString(texts: exit)
    }
    
    @IBAction func didTapDetail() {
        if let item = item {
            delegate?.didTapDetail(transition: item)
        }
    }
}
