//
//  SignupViewController.swift
//  Copilot
//
//  Created by Jamal on 10/5/23.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {
    
    var viewModel: SignupViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var nameTextField: CPTextField!
    @IBOutlet weak var phoneTextField: CPTextField!
    @IBOutlet weak var emailTextFiled: CPEmailTextField!
    @IBOutlet weak var taxTextField: CPTextField!
    @IBOutlet weak var plateNumberTextField: CPTextField!
    @IBOutlet weak var licenseTextField: CPTextField!
    @IBOutlet weak var passwordTextFiled: CPPasswordTextField!
    @IBOutlet weak var repeatPasswordTextFiled: CPPasswordTextField!
    
    @IBOutlet weak var clarificationCheckBox: CPCheckBox!
    @IBOutlet weak var clarificationLabel: UILabel!
    @IBOutlet weak var clarificationErrorView: CPErrorView!
    
    @IBOutlet weak var marketingCheckBox: CPCheckBox!
    @IBOutlet weak var marketingLabel: UILabel!
    
    @IBOutlet weak var smsCheckBox: CPCheckBox!
    @IBOutlet weak var smsLabel: UILabel!
    
    @IBOutlet weak var telephoneCheckBox: CPCheckBox!
    @IBOutlet weak var telephoneLabel: UILabel!
    
    @IBOutlet weak var emailCheckBox: CPCheckBox!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var signupButton: CPButton!
    @IBOutlet weak var isMemberLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    private var clarfication: Bool = false
    
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
        nameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        emailTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        taxTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        plateNumberTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        licenseTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        repeatPasswordTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        signupButton.isEnabled = false
        
        phoneTextField.keyboardType = .phonePad
        taxTextField.keyboardType = .numberPad
        
        phoneTextField.delegate = self
        taxTextField.delegate = self
        
        clarificationErrorView.isHidden = true
    }
    
    func applyStyle() {
        countryCodeView.layer.cornerRadius = 6
        countryCodeView.layer.borderWidth = 1
        countryCodeView.layer.borderColor = UIColor.textGrey.cgColor
        countryLabel.apply(.greyS12R400)
        descriptionLabel.apply(.blackS16M500)
        
        marketingLabel.apply(.greyS12R400)
        smsLabel.apply(.greyS12R400)
        telephoneLabel.apply(.greyS12R400)
        emailLabel.apply(.greyS12R400)
        signupButton.isSmallFontSize = true
        
        isMemberLabel.apply(.greyS16B400)
        loginButton.apply(.themeS16B700)
    }
    
    func setTexts() {
        descriptionLabel.text = Strings.signupDescription
        nameTextField.placeholder = Strings.nameSurname
        phoneTextField.placeholder = Strings.phoneNumber
        emailTextFiled.placeholder = Strings.yourEmailAdress
        taxTextField.placeholder = Strings.taxIdNumber
        plateNumberTextField.placeholder = Strings.plateNumber
        licenseTextField.placeholder = Strings.vehicleLicenseNumber
        passwordTextFiled.placeholder = Strings.password
        repeatPasswordTextFiled.placeholder = Strings.repeatPassword
        setClarificationText()
        marketingLabel.text = Strings.marketingApprovement
        signupButton.setTitle(Strings.becomeMember, for: .normal)
        
        isMemberLabel.text = Strings.areYouMember
        clarificationErrorView.message = Strings.clarificationError
        smsLabel.text = Strings.sms
        telephoneLabel.text = Strings.telefon
        emailLabel.text = Strings.emailPlaceholder
        
        loginButton.setAttributedTitle(Strings.login.underLined, for: .normal)
    }
    
    func setClarificationText(color: UIColor = .textGrey) {
        let calrification = AttributedText(text: Strings.clarificationDescription, fontSize: 12, style: .regular, textColor: color)
        let calrificationUnderlined = AttributedText(text: Strings.clarificationText, fontSize: 12, style: .bold, textColor: color)
        clarificationLabel.attributedText = AttributedText.createUnderlinedString(mainText: calrification, underlinedText: calrificationUnderlined)
    }
    
    func setButtonActivation() {
        let name = nameTextField.pureTextCount > 0
        let phone = phoneTextField.pureTextCount == 11
        let email = emailTextFiled.validate()
        let tcTax = taxTextField.pureTextCount == 11
        let plate = plateNumberTextField.pureTextCount > 0
        let license = licenseTextField.pureTextCount > 0
        let password = passwordTextFiled.pureTextCount > 0
        let repeatPass = repeatPasswordTextFiled.pureTextCount > 0
        signupButton.isEnabled = name && phone && email && tcTax && plate && license && password && repeatPass
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        setButtonActivation()
    }
    
    @IBAction func didTapClarificationCheckBox(_ sender: UIButton) {
        clarificationCheckBox.isSelected = !clarificationCheckBox.isSelected
        if clarificationCheckBox.isSelected {
            clarificationErrorView.isHidden = true
            setClarificationText()
        }
        setButtonActivation()
    }
    
    @IBAction func didTapMarketingCheckBox(_ sender: UIButton) {
        marketingCheckBox.isSelected = !marketingCheckBox.isSelected
    }
    
    @IBAction func didTapSMSCheckBox(_ sender: UIButton) {
        smsCheckBox.isSelected = !smsCheckBox.isSelected
    }
    
    @IBAction func didTapTelephoneCheckBox(_ sender: UIButton) {
        telephoneCheckBox.isSelected = !telephoneCheckBox.isSelected
    }
    
    @IBAction func didTapEmailCheckBox(_ sender: UIButton) {
        emailCheckBox.isSelected = !emailCheckBox.isSelected
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        
        let password = passwordTextFiled.text ?? ""
        let repeatPass = repeatPasswordTextFiled.text
        if password != repeatPass {
            showError(title: Strings.error, message: Strings.passwordsShouldBeSame)
            return
        }
        
        let clarification = clarificationCheckBox.isSelected
        clarificationErrorView.isHidden = clarification
        
        if !clarification {
            setClarificationText(color: .theme)
            return
        }
        
        viewModel.signup(name: nameTextField.text ?? "",
                         phone: phoneTextField.text ?? "",
                         email: emailTextFiled.text ?? "",
                         taxId: taxTextField.text ?? "",
                         plateNumber: plateNumberTextField.text ?? "",
                         licence: licenseTextField.text ?? "",
                         password: passwordTextFiled.text ?? "")
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        viewModel.goToLogin()
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        return range.location < 11
    }
}

extension SignupViewController: SignupViewModelDelegate {
    
}
