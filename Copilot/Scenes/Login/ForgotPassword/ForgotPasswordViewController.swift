//
//  ForgotPasswordViewController.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    var viewModel: ForgotPasswordViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailTextFiled: CPEmailTextField!
    @IBOutlet weak var phoneTextField: CPPhoneTextField!
    @IBOutlet weak var sendButton: CPButton!
    
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
        emailTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        sendButton.isEnabled = false
        phoneTextField.keyboardType = .phonePad
    }
    
    func applyStyle() {
        backImageView.image = backImageView.image?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = .black
        titleLabel.apply(.blackS18B700)
        descriptionLabel.apply(.blackS16R400)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.forgot.password.title")
        descriptionLabel.text = App.getString(key: "copilotapp.forgot.password.description")
        phoneTextField.placeholder = App.getString(key: "copilotapp.sign.up.phone.input.description")
        emailTextFiled.placeholder = App.getString(key: "copilotapp.forgot.password.email.input.description")
        sendButton.setTitle(App.getString(key: "copilotapp.forgot.password.button"), for: .normal)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        let email = emailTextFiled.validate()
        let phone = phoneTextField.validate()
        sendButton.isEnabled = email && phone
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        viewModel.sendPassword(email: emailTextFiled.text ?? "",
                              phone: phoneTextField.text ?? "")
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        viewModel.getBack()
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewModelDelegate {
    func showSuccess(title: String, message: String, buttonTitle: String) {
        showSuccess(successTitle: title, message: message, buttonTitle: buttonTitle)
    }
}
