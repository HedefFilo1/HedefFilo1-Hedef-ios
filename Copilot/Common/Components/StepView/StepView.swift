//
//  StepView.swift
//  Copilot
//
//  Created by Jamal on 6/10/24.
//

import Foundation
import UIKit

class StepView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var step1ImageView: UIImageView!
    @IBOutlet weak var step1TitleLabel: UILabel!
    @IBOutlet weak var step1SubLabel: UILabel!
    
    @IBOutlet weak var step2ImageView: UIImageView!
    @IBOutlet weak var step2TitleLabel: UILabel!
    @IBOutlet weak var step2SubLabel: UILabel!
    
    private var nibName: String {
        return String(describing: type(of: self))
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        applyStyles()
        setTexts()
    }
    
    private func applyStyles() {
        backgroundColor = .clear
        step1TitleLabel.apply(.blackS14B700)
        step1SubLabel.apply(.greyS12R400)
        
        step2TitleLabel.apply(.blackS14B700)
        step2SubLabel.apply(.greyS12R400)
    }
    
    func setTexts() {
        step1TitleLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.info")
        step1SubLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.info.description")
        
        step2TitleLabel.text = App.getString(key: "copilotapp.accidentdamage.vehicle.status")
        step2SubLabel.text = App.getString(key: "copilotapp.accidentdamage.vehicle.status.description")
    }
    
}
