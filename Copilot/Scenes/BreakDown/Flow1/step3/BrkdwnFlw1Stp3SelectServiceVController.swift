//
//  BrkdwnFlw1Stp3SelectServiceVController.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation
import UIKit

class BrkdwnFlw1Stp3SelectServiceVController: UIViewController {
    
    var viewModel: BrkdwnFlw1Stp3SelectServiceViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var serviceButton: CPLightButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
//        pointsView.imageView.image = Images.lastikPoints
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.blackS20B700)
        secondLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.title")
        descriptionLabel.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.engine.title")
        secondLabel.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.engine.description")
        serviceButton.setTitle(App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.engine.service.choice.button"), for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapService() {
        viewModel.goToServices()
    }
}

extension BrkdwnFlw1Stp3SelectServiceVController: BrkdwnFlw1Stp3SelectServiceVMDelegate {
    
}
