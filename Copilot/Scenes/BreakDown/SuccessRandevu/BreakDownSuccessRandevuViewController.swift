//
//  BreakDownSuccessRandevuViewController.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation
import UIKit

class BreakDownSuccessRandevuViewController: UIViewController {

    var viewModel: BreakDownSuccessRandevuViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var randveuView: UIView!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var editButton: CPLightButton!
    @IBOutlet weak var homeButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setRandevu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.viewControllers.removeAll { (controller) -> Bool in
            return controller.isKind(of: ServiceRandevuViewController.self)
        }
        circleView.layer.cornerRadius = circleView.bounds.height/2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        editButton.isEnabled = true
        homeButton.isEnabled = true
    }
    
    func applyStyle() {
        circleView.layer.cornerRadius = 40
        titleLabel.apply(.blackS18B700)
        desciptionLabel.apply(.greyS14R400)
        randveuView.layer.cornerRadius = 10
        randveuView.layer.borderColor = UIColor.borderColor.cgColor
        randveuView.layer.borderWidth = 1
    
        supplierNameLabel.apply(.blackS20B700)
        addressLabel.apply(.greyS12R400)
        phoneLabel.apply(.blackS12R400)
        dateLabel.apply(.blackS16R400)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.servicebreakdown.service.success.title")
        desciptionLabel.text = App.getString(key: "copilotapp.servicetire.appointment.confirmation.confirm.success.description")
        if viewModel.date != nil {
            desciptionLabel.text = ""
        }
        editButton.setTitle(App.getString(key: "copilotapp.servicebreakdown.service.success.edit.button"), for: .normal)
        homeButton.setTitle(App.getString(key: "copilotapp.servicebreakdown.service.success.back.homepage.button"), for: .normal)
    }

    @IBAction func didTapClose() {
        viewModel.getBack()
    }
    
    @IBAction func didTapEdit() {
        viewModel.getBack()
    }
    
    @IBAction func didTapHome() {
        viewModel.getBackToHome()
    }
    
    func setRandevu() {
        var phone = ""
        if let service = viewModel.service {
            supplierNameLabel.text = service.name
            addressLabel.text = service.address
            phoneLabel.text = service.phone
            phone = service.phone ?? ""
            
        } else if let appointment = viewModel.appointment {
            supplierNameLabel.text = appointment.supplierName
            addressLabel.text = appointment.address
            phoneLabel.text = appointment.supplierPhone
        }
        
        if let date = viewModel.displayDate {
            dateLabel.text = date
        } else {
            phoneLabel.text = "\(phone)\n"
            dateLabel.removeFromSuperview()
        }
    }
}

extension BreakDownSuccessRandevuViewController: BreakDownSuccessRandevuViewModelDelegate {
    
}
