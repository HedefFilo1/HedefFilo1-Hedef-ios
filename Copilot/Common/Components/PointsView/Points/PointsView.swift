//
//  PointsView.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import UIKit

class PointsView: UIView {
    var currentPoint = 0
    
    var barPoints: [BarPoint]? {
        didSet {
            guard let barPoints, barPoints.count > 0 else { return }
            addPointView()
            //            startAnimate()
        }
    }
    
    var maxPoint: Int {
        if let barPoints, barPoints.count > 0 {
            let max = barPoints.max(by: { $0.point < $1.point })
            var value = max?.point ?? 0
            if currentPoint > value {
                value = currentPoint
            }
            return value
        }
        return 200
    }
    
    var pointFrameRate: CGFloat {
        return pointsContainer.frame.width / CGFloat(maxPoint)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var animationContainerView: UIView!
    @IBOutlet weak var progressContainerView: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressConstraint: NSLayoutConstraint!
    @IBOutlet weak var pointsContainer: UIView!
    
    private var nibName: String {
        return String(describing: type(of: self))
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        applyStyles()
        progressConstraint.constant = 4
        clipsToBounds = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(tap)
        contentView.clipsToBounds = false
        //        startAnimate()
    }
    
    private func applyStyles() {
        progressContainerView.layer.cornerRadius = 7
        progressContainerView.backgroundColor = .disabled
        progressView.layer.cornerRadius = 7
    }
    
    @objc func didTap() {
        //        startAnimate()
    }
    
    func startAnimate() {
        progressConstraint.constant = 0
        var point = pointFrameRate * CGFloat(currentPoint) + 40
        if point < 40 {
            point = 40
        }
        progressConstraint.constant = point
        
        if progressConstraint.constant < 40 {
            progressConstraint.constant = 45
        }
        UIView.animate(withDuration: 0, delay: 0) {
            self.progressContainerView.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
    
    func addPointView() {
        
        guard let barPoints else { return }
        let width = pointsContainer.frame.width
        let count = barPoints.count
        let distance = width/CGFloat(count - 1)
        
        for item in barPoints {
            let pointView = PointView(frame: .zero)
            pointsContainer.addSubview(pointView)
            let leading = CGFloat(item.point) * pointFrameRate
            pointView.align(top: 10, leading: leading - 40, bottom: 0, width: 70)
            pointView.titleLabel.text = item.name
            let text = App.getString(key: "copilotapp.gamification.point")?.replacingOccurrences(of: "{point}", with: "") ?? ""
            pointView.valueLabel.text = "\(item.point)\(text)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.startAnimate()
        }
    }
}
