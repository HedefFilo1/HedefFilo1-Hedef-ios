//
//  MaintenanceStep2KMViewController.swift
//  Copilot
//
//  Created by Jamal on 1/30/24.
//

import Foundation
import UIKit

class MaintenanceStep2KMViewController: UIViewController {

    var viewModel: MaintenanceStep2KMViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var kmTextField: CPTextField!
    @IBOutlet weak var continueButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
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
        kmTextField.keyboardType = .numberPad
        continueButton.isEnabled = false
        kmTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        kmTextField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        kmTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        kmLabel.apply(.blackS14B700)
        desciptionLabel.apply(.greyS12R400)
     
    }
    
    func setTexts() {
        titleLabel.text = Strings.createMaintenanceAppointment
        kmLabel.text = Strings.vehicleMileage
        kmTextField.placeholder = Strings.enterVehicleMileage
        desciptionLabel.text = Strings.maintenanceKMDescription
        continueButton.setTitle(Strings.devamEt, for: .normal)
    }
    
    func setButtonActivation() {
        let text = kmTextField.pureTextCount > 0
        continueButton.isEnabled = text
    }
    
    @objc
    func editingChanged() {
        setButtonActivation()
    }
    
    @objc
    func editingDidBegin() {
        kmTextField.text = kmTextField.text?.replacingOccurrences(of: " KM", with: "")
    }
    
    @objc
    func editingDidEnd() {
        if let text = kmTextField.text {
            kmTextField.text = "\(text) KM"
        }
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }

    @IBAction func didContinue() {
//        viewModel.goToNotMaintenancePeriod()
        guard let text = kmTextField.text?.replacingOccurrences(of: " KM", with: "") else { return }
        if let kmeter = Int(text) {
            viewModel.checkEligible(kmeter: kmeter)
        }
    }
}

extension MaintenanceStep2KMViewController: MaintenanceStep2KMViewModelDelegate {
    
}