//
//  AccFlw1Stp1ViewController.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import UIKit

class AccFlw1Stp1VController: UIViewController {
    
    var viewModel: AccFlw1Stp1ViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questonLabel: UILabel!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var continueButton: CPGreyButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
        continueButton.isEnabled = true
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        questonLabel.apply(.blackS20B700)
        descriptionLabel.apply(.greyS12R400)
        callView.layer.cornerRadius = 10
        callView.backgroundColor = .theme
        callLabel.apply(.whiteS16B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.accidentOperations
        descriptionLabel.text = Strings.medicalHelpQuestion
        callLabel.text = Strings.call112
        continueButton.setTitle(Strings.goToAccidentPage, for: .normal)
        descriptionLabel.text = Strings.goToAccidentPageDescription
    }
    
    @IBAction func didTapCall() {
        guard let url = URL(string: CodeStrings.call112) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func didTapContinue() {
        viewModel.goToAccFlw1Stp2OtherVehicle()
    }
}

extension AccFlw1Stp1VController: AccFlw1Stp1ViewModelDelegate {
    
}
