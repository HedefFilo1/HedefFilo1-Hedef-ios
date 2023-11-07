//
//  PointsCell.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import UIKit

protocol PointsCellDelegate: AnyObject {
    func seeAllPoints()
}

class PointsCell: UICollectionViewCell, Reusable {
    
    weak var delegate: PointsCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var howLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pointsView: PointsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS20B700)
        howLabel.apply(.themeS12B700)
        setPointsLabel(point: 420)
    }
    
    func setTexts() {
        titleLabel.text = Strings.standings
    }
    
    func setPointsLabel(point: Int) {
        let main = AttributedText(text: "\(Strings.yourScore): \(point)",
                                  type: .greyS12R400)
        let point = AttributedText(text: "\(point)", type: .blackS12B700)
        pointsLabel.attributedText = AttributedText.createMultiplePartString(mainText: main, texts: [point])
    }
    
    @IBAction func didTapSeeAll() {
        delegate?.seeAllPoints()
    }
}
