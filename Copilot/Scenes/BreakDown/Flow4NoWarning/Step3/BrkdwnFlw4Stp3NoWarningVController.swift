//
//  BrkdwnFlw4Stp3NoWarningVController.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import Foundation
import UIKit

class BrkdwnFlw4Stp3NoWarningVController: UIViewController {
    
    var viewModel: BrkdwnFlw4Stp3NoWarningViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var homeButton: CPButton!
    @IBOutlet weak var serviceButton: CPLightButton!
    @IBOutlet weak var guidLabel: UILabel!
    
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
        applyStyle()
        setTexts()
        homeButton.isEnabled = true
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        warningLabel.apply(.blackS18B700)
        descriptionLabel.apply(.greyS14R400)
        guidLabel.apply(.themeS14B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.breakDownOperations
        warningLabel.text = Strings.pleaseSelectService
        descriptionLabel.text = Strings.turnOffRestartVehicle
        homeButton.setTitle(Strings.returnToHomePage, for: .normal)
        serviceButton.setTitle(Strings.proceedServiceSelection, for: .normal)
        guidLabel.text = Strings.goToWarningLightsGuide
    }
    
    @IBAction func didTapHome() {
        viewModel.getBackToHome()
    }
    
    @IBAction func didTapService() {
        viewModel.goToServices()
    }
    
    @IBAction func didTapGuide() {
        
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension BrkdwnFlw4Stp3NoWarningVController: BrkdwnFlw4Stp3NoWarningVMDelegate {
    
}
