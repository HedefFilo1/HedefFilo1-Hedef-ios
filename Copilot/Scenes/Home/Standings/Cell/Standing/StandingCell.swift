//
//  StandingCell.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import UIKit

class StandingCell: UICollectionViewCell, Reusable {
    
    var totalPoints: Int = 0 {
        didSet {
            setPointsLabel(point: totalPoints)
            pointsView.currentPoint = totalPoints
        }
    }
    
    var barPoints: [BarPoint]? {
        didSet {
            pointsView.barPoints = barPoints
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pointsView: PointsView!
    @IBOutlet weak var howLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
    }
    
    private func applyStyles() {
        titleLabel.apply(.greyS14R400)
        setPointsLabel(point: 420)
        howLabel.apply(.blackS14B700)
    }
    
    func setPointsLabel(point: Int) {
        let main = AttributedText(text: "\(Strings.yourScore): \(point)",
                                  type: .greyS14R400)
        let point = AttributedText(text: "\(point)", type: .blackS18B700)
        pointsLabel.attributedText = AttributedText.createMultiplePartString(mainText: main, texts: [point])
    }
}
