//
//  RequestSuccessViewController.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation
import UIKit

class RequestSuccessViewController: UIViewController {
    
    var viewModel: RequestSuccessViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var headLabel: UILabel!
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
        headLabel.apply(.blackS18R400)
        titleLabel.apply(.blackS18R400)
        descriptionLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
//        titleLabel.text = viewModel.tireType == .winter ? Strings.winterTireRequestReceived: Strings.summerTireRequestReceived
//        descriptionLabel.text = Strings.requestLastikResultText
//        requestsButton.setTitle(Strings.goToRequests, for: .normal)
//        homeButton.setTitle(Strings.returnToHomePage, for: .normal)
        titleLabel.text = viewModel.title
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

extension RequestSuccessViewController: RequestSuccessViewModelDelegate {
    
}
