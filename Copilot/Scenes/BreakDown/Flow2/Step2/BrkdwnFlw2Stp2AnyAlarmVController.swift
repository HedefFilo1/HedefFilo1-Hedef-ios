//
//  BreakdownFlow2Step2AnyAlarmVController.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation
import UIKit

class BrkdwnFlw2Stp2AnyAlarmVController: UIViewController {
    
    var viewModel: BrkdwnFlw2Stp2AnyAlarmViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var warningsLabel: UILabel!
    @IBOutlet weak var yesButton: CPLightButton!
    @IBOutlet weak var noButton: CPLightButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.greyS12R400)
        questionLabel.apply(.blackS20B700)
        warningsLabel.apply(.themeS14B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.breakDownOperations
        descriptionLabel.text = Strings.followTheInstructions
        questionLabel.text = Strings.anyWarningLightOn
        yesButton.setTitle(Strings.lightOn, for: .normal)
        noButton.setTitle(Strings.lightOff, for: .normal)
        warningsLabel.text = Strings.goToWarningLightsGuide
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapYes() {
        viewModel.goToBrkdwnFlw1Stp3SelectService()
    }
    
    @IBAction func didTapNo() {
        viewModel.getBack()
    }
    
    @IBAction func didTapGoToWarnings() {
        
    }
}

extension BrkdwnFlw2Stp2AnyAlarmVController: BrkdwnFlw2Stp2AnyAlarmViewModelDelegate {
    
}
