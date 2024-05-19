//
//  AccFlw1Stp7SelectServiceViewController.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation
import UIKit

class AccFlw1Stp7SelectServiceViewController: UIViewController {
    
    var viewModel: AccFlw1Stp7SelectServiceViewModelType! {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        titleLabel.text = App.getString(key: "copilotapp.accidentdamage.title")
        descriptionLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.get.well.soon.title")
        secondLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.get.well.soon.description")
        serviceButton.setTitle(App.getString(key: "copilotapp.accidentdamage.accident.process.proceed.service.selection.button"), for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapService() {
        viewModel.goToServices()
    }
}

extension AccFlw1Stp7SelectServiceViewController: AccFlw1Stp7SelectServiceVMDelegate {
    
}
