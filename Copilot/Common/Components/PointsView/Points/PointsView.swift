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
    
    @IBOutlet weak var progressContainerView: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressConstraint: NSLayoutConstraint!
    
    private var nibName: String {
        return String(describing: type(of: self))
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        applyStyles()
        progressConstraint.constant = 45
        clipsToBounds = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(tap)
        
        addPointView()
//        startAnimate()
    }
    
    private func applyStyles() {
        progressContainerView.layer.cornerRadius = 7
        progressContainerView.backgroundColor = .disabled
        progressView.layer.cornerRadius = 7
    }
    
    @objc func didTap() {
        progressConstraint.constant = progressContainerView.frame.width * 0.7
        startAnimate()
    }
    
    func startAnimate() {
        UIView.animate(withDuration: 2, delay: 2) {
            self.layoutIfNeeded()
        }
    }
    
    func addPointView() {
        let pointView = PointView(frame: .zero)
        addSubview(pointView)
        pointView.align(trailing: -50, bottom: 0, width: 100)
        pointView.align(toView: progressContainerView, top: -6)
        startAnimate()
    }
}
