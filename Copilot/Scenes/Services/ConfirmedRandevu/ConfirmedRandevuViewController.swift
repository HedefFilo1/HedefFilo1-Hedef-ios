//
//  ConfirmedRandevuViewController.swift
//  Copilot
//
//  Created by Jamal on 1/3/24.
//

import Foundation
import UIKit

class ConfirmedRandevuViewController: UIViewController {

    var viewModel: ConfirmedRandevuViewModelType! {
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
//        titleLabel.text = Strings.randevuRequestSuccessMessage
        titleLabel.text = App.getString(key: "copilotapp.success.tire.damage")
        if let tireSupportType = viewModel.tireSupportType {
            if tireSupportType == .damage {
                titleLabel.text = App.getString(key: "copilotapp.success.tire.damage")
            } else {
                titleLabel.text = App.getString(key: "copilotapp.servicetire.appointment.confirmation.confirm.success.title")
            }
        }
        desciptionLabel.text = App.getString(key: "copilotapp.servicebreakdown.service.success.description")
        editButton.setTitle(App.getString(key: "copilotapp.servicetire.appointment.confirmation.edit.appointment.button"), for: .normal)
        homeButton.setTitle(App.getString(key: "copilotapp.servicetire.tire.operation.winter.tire.new.winter.tire.request.received.back.homepage.button"), for: .normal)
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
        if let service = viewModel.service {
            supplierNameLabel.text = service.name
            addressLabel.text = service.address
            phoneLabel.text = service.phone
            
        } else if let appointment = viewModel.appointment {
            supplierNameLabel.text = appointment.supplierName
            addressLabel.text = appointment.address
            phoneLabel.text = appointment.supplierPhone
        }
        dateLabel.text = viewModel.displayDate
    }
}

extension ConfirmedRandevuViewController: ConfirmedRandevuViewModelDelegate {
    
}
