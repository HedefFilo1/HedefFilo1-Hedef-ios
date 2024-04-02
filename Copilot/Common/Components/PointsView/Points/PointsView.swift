//
//  PointsView.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import UIKit

class PointsView: UIView {
    var barPoints: [BarPoint]? {
        didSet {
            guard let barPoints, barPoints.count > 0 else { return }
            addPointView()
            //            startAnimate()
        }
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
        progressConstraint.constant = progressContainerView.frame.width * 0.45
        if progressConstraint.constant < 40 {
            progressConstraint.constant = 45
        }
        UIView.animate(withDuration: 3, delay: 0) {
            self.progressContainerView.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
    
    func addPointView() {
        
        guard let barPoints else { return }
        let width = pointsContainer.frame.width
        let count = barPoints.count
        let distance = width/CGFloat(count - 1)
        var lastLeading: CGFloat = -40
        
        for item in barPoints {
            let pointView = PointView(frame: .zero)
            pointsContainer.addSubview(pointView)
            pointView.align(top: 10, leading: lastLeading, bottom: 0, width: 70)
            lastLeading += distance
            pointView.titleLabel.text = item.name
            pointView.valueLabel.text = "\(item.point) \(Strings.point)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.startAnimate()
        }
    }
}
