//
//  LastikConfirmInfoViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/26/23.
//

import Foundation
import UIKit

class Flow4Step3SelectServiceViewController: UIViewController {
    
    var viewModel: Flow4Step3SelectServiceViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
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
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.blackS20B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.servicetire.tire.operation.title")
        descriptionLabel.text = App.getString(key: "copilotapp.servicetire.tire.operation.without.tow.truck.title")
        serviceButton.setTitle(App.getString(key: "copilotapp.servicetire.tire.operation.take.paid.tow.truck.get.well.soon.proceed.service.selection.button"), for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapService() {
        viewModel.goToServices()
    }
}

extension Flow4Step3SelectServiceViewController: Flow4Step3SelectServiceViewModelDelegate {
    
}
