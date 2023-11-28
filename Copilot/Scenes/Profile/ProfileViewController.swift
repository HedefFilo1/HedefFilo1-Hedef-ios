//
//  ProfileViewController.swift
//  Copilot
//
//  Created by Jamal on 10/13/23.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    lazy var viewModel: ProfileViewModelType = {
        let viewModel = ProfileViewModel()
        let coordinator = ProfileCoordinator(with: self.navigationController!)
        viewModel.coordinatorDelegate = coordinator
        viewModel.delegate = self
        return viewModel
    }()
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneTextField: CPPhoneTextField!
    @IBOutlet weak var emailTextFiled: CPEmailTextField!
    @IBOutlet weak var nameTextField: CPTextField!
    @IBOutlet weak var idTextField: CPTextField!
    @IBOutlet weak var licenseTextField: CPTextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var submitButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getProfile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
        nameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        emailTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        idTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        licenseTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        submitButton.isEnabled = false
        
        idTextField.keyboardType = .numberPad
        idTextField.delegate = self
        
        nameTextField.isEnabled = false
        idTextField.isEnabled = false
        licenseTextField.isEnabled = false
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        passwordLabel.apply(.blackS14M500)
    }
    
    func setTexts() {
        phoneTextField.placeholder = Strings.mobilePhone
        emailTextFiled.placeholder = Strings.email
        nameTextField.placeholder = Strings.nameSurname
        idTextField.placeholder = Strings.taxIdNumber
        licenseTextField.placeholder = Strings.vehicleLicenseNumber
        passwordLabel.text = Strings.resetPassword
        submitButton.setTitle(Strings.updateInformation, for: .normal)
    }
    
    func setButtonActivation() {
        let phone = phoneTextField.validate()
        let email = emailTextFiled.validate()
        submitButton.isEnabled = phone && email
    }
    
    @objc func editingChanged(_ textField: UITextField) {
       setButtonActivation()
    }
    
    @IBAction func didTapResetPassword(_ sender: UIButton) {
        viewModel.goToResetPassword()
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        viewModel.submit(name: nameTextField.text ?? "",
                         phone: phoneTextField.text ?? "",
                         email: emailTextFiled.text ?? "",
                         id: idTextField.text ?? "",
                         licence: licenseTextField.text ?? "")
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        return range.location < 11
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func setProfile() {
        if let profile = viewModel.profile {
            phoneTextField.preText = profile.phoneNumber
            emailTextFiled.preText = profile.email
            let name = profile.name ?? ""
            let surname = profile.surname ?? ""
            nameTextField.preText = name + " " + surname
            idTextField.preText = profile.taxId
            licenseTextField.preText = profile.licenseNumber
            setButtonActivation()
        }
    }
}
