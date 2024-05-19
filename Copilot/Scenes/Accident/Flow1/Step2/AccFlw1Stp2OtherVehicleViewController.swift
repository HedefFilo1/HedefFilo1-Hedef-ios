//
//  AccFlw1Stp2OtherVehicleViewController.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import UIKit

class AccFlw1Stp2OtherVehicleViewController: UIViewController {
    
    var viewModel: AccFlw1Stp2OtherVehicleViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var questonLabel: UILabel!
    @IBOutlet weak var yesButton: CPLightButton!
    @IBOutlet weak var noButton: CPLightButton!
    @IBOutlet weak var footerLabel: UILabel!
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
        setBasicViews()
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.greyS14R400)
        questonLabel.apply(.blackS20B700)
        footerLabel.apply(.greyS12R400)
        guidLabel.apply(.themeS14B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.accidentdamage.title")
        descriptionLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.description")
        questonLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.other.vehicle.accident.question")
        yesButton.setTitle(App.getString(key: "copilotapp.accidentdamage.accident.process.other.vehicle.accident.yes"), for: .normal)
        noButton.setTitle(App.getString(key: "copilotapp.accidentdamage.accident.process.other.vehicle.accident.no"), for: .normal)
        footerLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.info.after")
        guidLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.go.accident.guide.button")
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapYes() {
        AccidentCoordinator.accidentType = .twoSide
        viewModel.goToAccFlw1Stp3Agreement()
    }
    
    @IBAction func didTapNo() {
        AccidentCoordinator.accidentType = .oneSide
        AccidentCoordinator.accidentReportType = .beyan
        viewModel.goToAccFlw5Stp3Declare()
    }

    @IBAction func didTapGuide() {
        APIService.addUserAction(pageName: "Damage", actionName: "DAMAGE_GO_ACCIDENT_GUIDE")
        viewModel.goToGuide()
    }
}

extension AccFlw1Stp2OtherVehicleViewController: AccFlw1Stp2OtherVehicleViewModelDelegate {
    
}
