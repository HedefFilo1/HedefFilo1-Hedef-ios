//
//  ServiceTabViewController.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation
import UIKit

class ServiceTabViewController: UIViewController {
    
    lazy var viewModel: ServiceTabViewModelType = {
        let viewModel = ServiceTabViewModel()
        let coordinator = ServicesCoordinator(with: self.navigationController!)
        viewModel.coordinatorDelegate = coordinator
        viewModel.delegate = self
        return viewModel
    }()
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var careButton: CPLightButton!
    @IBOutlet weak var faultButton: CPLightButton!
    @IBOutlet weak var lastikButton: CPLightButton!
    @IBOutlet weak var pastServicesButton: CPGreyButton!
    
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
        descriptionLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.service
        descriptionLabel.text = Strings.selectService
        careButton.setTitle(Strings.care, for: .normal)
        faultButton.setTitle(Strings.fault, for: .normal)
        lastikButton.setTitle(Strings.lastik, for: .normal)
        pastServicesButton.setTitle(Strings.pastServiceTransactions, for: .normal)
    }
    
    @IBAction func didTapCareButton() {
        
    }
    
    @IBAction func didTapFaultButton() {
        
    }
    
    @IBAction func didTapLastikButton() {
        viewModel.goToLastikOperations()
    }
    
    @IBAction func didTapPastServicesButton() {
        
    }
}

extension ServiceTabViewController: ServiceTabViewModelDelegate {
    
}
