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
        titleLabel.text = App.getString(key: "copilotapp.gamification.standings")
        howLabel.text = App.getString(key: "copilotapp.gamification.standings.how_to_earn_points")
    }
    
    func setPointsLabel(point: Int) {
        let score = App.getString(key: "copilotapp.gamification.your_point") ?? ""
        let main = AttributedText(text: "\(score): \(point)",
                                  type: .greyS12R400)
        let point = AttributedText(text: "\(point)", type: .blackS12B700)
        pointsLabel.attributedText = AttributedText.createMultiplePartString(mainText: main, texts: [point])
    }
    
    @IBAction func didTapSeeAll() {
        delegate?.seeAllPoints()
    }
}
