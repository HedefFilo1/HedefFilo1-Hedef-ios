//
//  CanceledRequestViewController.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import Foundation
import UIKit

class CanceledRequestViewController: UIViewController {
    
    var viewModel: CanceledRequestViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
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
        requestsButton.apply(.custom(.theme, .medium, 20))
        homeButton.apply(.custom(.white, .medium, 20))
    }
    
    func setTexts() {
        headLabel.text = viewModel.title
        titleLabel.text = Strings.requestCanceledMessage
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

extension CanceledRequestViewController: CanceledRequestViewModelDelegate {
    
}
