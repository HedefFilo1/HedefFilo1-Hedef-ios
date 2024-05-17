//
//  BreakdownFlow1Step2TowTruckVController.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation
import UIKit

class BrkdwnFlw1Stp2TowTruckVController: UIViewController {
    
    var viewModel: BrkdwnFlw1Stp2TowTruckViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
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
        descriptionLabel.apply(.blackS20B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.title")
        descriptionLabel.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.paid.tow.truck.question")
        yesButton.setTitle(App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.paid.tow.truck.yes.button"), for: .normal)
        noButton.setTitle(App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.paid.tow.truck.no.button"), for: .normal)
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
}

extension BrkdwnFlw1Stp2TowTruckVController: BrkdwnFlw1Stp2TowTruckViewModelDelegate {
    
}
