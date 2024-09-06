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
        setTexts()
    }
    
    private func applyStyles() {
        titleLabel.apply(.greyS14R400)
        setPointsLabel(point: 420)
        howLabel.apply(.blackS14B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.gamification.standings.description")
        howLabel.text = App.getString(key: "copilotapp.gamification.standings.how_to_earn_points")
    }
    
    func setPointsLabel(point: Int) {
        let score = App.getString(key: "copilotapp.gamification.your_point") ?? ""
        let main = AttributedText(text: "\(score): \(point)",
                                  type: .greyS14R400)
        let point = AttributedText(text: "\(point)", type: .blackS18B700)
        pointsLabel.attributedText = AttributedText.createMultiplePartString(mainText: main, texts: [point])
    }
}
