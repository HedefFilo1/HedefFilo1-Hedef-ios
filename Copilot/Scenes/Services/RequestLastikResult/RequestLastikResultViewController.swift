//
//  RequestLastikResultViewController.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation
import UIKit

class RequestLastikResultViewController: UIViewController {
    
    var viewModel: RequestLastikResultViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var requestsButton: CPLightButton!
    @IBOutlet weak var homeButton: CPButton!
    
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
        clockView.layer.cornerRadius = 40
        titleLabel.apply(.blackS18B700)
        descriptionLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.winterTireRequestReceived
        descriptionLabel.text = Strings.requestLastikResultText
        requestsButton.setTitle(Strings.goToRequests, for: .normal)
        homeButton.setTitle(Strings.returnToHomePage, for: .normal)
    }
    
    @IBAction func didTapClose() {
        viewModel.getBack()
    }
    
    @IBAction func didTapRequests() {
        viewModel.goToRequests()
    }
    
    @IBAction func didTapHome() {
        viewModel.getBackToHome()
    }
}

extension RequestLastikResultViewController: RequestLastikResultViewModelDelegate {
    
}