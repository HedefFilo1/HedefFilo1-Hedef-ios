//
//  RequestLastikResultViewController.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation
import UIKit

class Flow1Step4ResultViewController: UIViewController {
    
    var viewModel: Flow1Step4ResultViewModelType! {
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
        requestsButton.isHidden = false
    }
    
    func applyStyle() {
        clockView.layer.cornerRadius = 40
        titleLabel.apply(.blackS18B700)
        descriptionLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
        let winter = App.getString(key: "copilotapp.servicetire.tire.operation.winter.tire.new.winter.tire.request.received.title") ?? ""
        let summer = App.getString(key: "copilotapp.servicetire.tire.operation.winter.tire.new.summer.tire.request.received.title") ?? ""
        titleLabel.text = viewModel.tireType == .winter ? winter: summer
        descriptionLabel.text = App.getString(key: "copilotapp.servicetire.tire.operation.winter.tire.new.winter.tire.request.received.description")
        requestsButton.setTitle(Strings.goToPastServices, for: .normal)
        homeButton.setTitle(App.getString(key: "copilotapp.servicetire.tire.operation.winter.tire.new.winter.tire.request.received.back.homepage.button"), for: .normal)
    }
    
    @IBAction func didTapClose() {
        viewModel.getBack()
    }
    
    @IBAction func didTapRequests() {
        viewModel.goToPastServices()
    }
    
    @IBAction func didTapHome() {
        viewModel.getBackToHome()
    }
}

extension Flow1Step4ResultViewController: Flow1Step4ResultViewModelDelegate {
    
}
