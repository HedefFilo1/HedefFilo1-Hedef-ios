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
    @IBOutlet weak var homeButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        requestsButton.apply(.custom(.theme, .regular, 20))
        homeButton.backgroundColor = .theme
        homeButton.apply(.custom(.white, .regular, 20))
        homeButton.layer.cornerRadius = 10
    }
    
    func setTexts() {
        headLabel.text = viewModel.title
        if viewModel.message.count > 0 {
            titleLabel.text = viewModel.message
        }
            
        descriptionLabel.text = App.getString(key: "copilotapp.demandproductservice.success.description")
        
        requestsButton.setTitle(App.getString(key: "copilotapp.demandproductservice.success.back.request.page.button"), for: .normal)
        homeButton.setTitle(App.getString(key: "copilotapp.demandproductservice.success.back.homepage.button"), for: .normal)
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
