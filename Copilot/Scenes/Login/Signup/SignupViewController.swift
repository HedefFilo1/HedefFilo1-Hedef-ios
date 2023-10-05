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
    @IBOutlet weak var idTextField: CPTextField!
    @IBOutlet weak var licenseTextField: CPTextField!
    @IBOutlet weak var passwordTextFiled: CPPasswordTextField!
    @IBOutlet weak var repeatPasswordTextFiled: CPPasswordTextField!
    
    @IBOutlet weak var clarificationCheckBox: CPCheckBox!
    @IBOutlet weak var clarificationLabel: UILabel!
    
    @IBOutlet weak var consentCheckBox: CPCheckBox!
    @IBOutlet weak var consentLabel: UILabel!
    
    @IBOutlet weak var marketingCheckBox: CPCheckBox!
    @IBOutlet weak var marketingLabel: UILabel!
    
    @IBOutlet weak var signupButton: CPButton!
    @IBOutlet weak var isMemberLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    private var clarfication: Bool = false
    private var consent: Bool = false
    
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
        idTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        licenseTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        repeatPasswordTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        signupButton.isEnabled = false
        
        phoneTextField.keyboardType = .phonePad
        idTextField.keyboardType = .numberPad
        
        phoneTextField.delegate = self
        idTextField.delegate = self
    }
    
    func applyStyle() {
        countryCodeView.layer.cornerRadius = 6
        countryCodeView.layer.borderWidth = 1
        countryCodeView.layer.borderColor = UIColor.textGrey.cgColor
        countryLabel.apply(.greyS12B400)
        descriptionLabel.apply(.blackS16M500)
        
        marketingLabel.apply(.greyS12B400)
        signupButton.isSmallFontSize = true
        
        isMemberLabel.apply(.greyS16B400)
        loginButton.apply(.themeS16B700)
    }
    
    func setTexts() {
        descriptionLabel.text = Strings.signupDescription
        nameTextField.placeholder = Strings.nameSurname
        phoneTextField.placeholder = Strings.phoneNumber
        emailTextFiled.placeholder = Strings.yourEmailAdress
        idTextField.placeholder = Strings.tcTaxNumber
        licenseTextField.placeholder = Strings.vehicleLicenseNumber
        passwordTextFiled.placeholder = Strings.password
        repeatPasswordTextFiled.placeholder = Strings.repeatPassword
        setAgreementTexts()
        marketingLabel.text = Strings.marketingApprovement
        signupButton.setTitle(Strings.becomeMember, for: .normal)
        
        isMemberLabel.text = Strings.areYouMember
        loginButton.setTitle(Strings.login, for: .normal)
    }
    
    func setAgreementTexts() {
        let calrification = AttributedText(text: Strings.clarificationDescription, fontSize: 12, style: .regular, textColor: .textGrey)
        let calrificationUnderlined = AttributedText(text: Strings.clarificationText, fontSize: 12, style: .bold, textColor: .textGrey)
        clarificationLabel.attributedText = AttributedText.createUnderlinedString(mainText: calrification, underlinedText: calrificationUnderlined)
        
        let consent = AttributedText(text: Strings.consentDescription, fontSize: 12, style: .regular, textColor: .textGrey)
        let consentUnderlined = AttributedText(text: Strings.consentText, fontSize: 12, style: .bold, textColor: .textGrey)
        consentLabel.attributedText = AttributedText.createUnderlinedString(mainText: consent, underlinedText: consentUnderlined)
    }
    
    func setButtonActivation() {
        let name = nameTextField.pureTextCount > 0
        let phone = phoneTextField.pureTextCount == 11
        let email = emailTextFiled.validate()
        let tcTax = idTextField.pureTextCount == 11
        let license = licenseTextField.pureTextCount > 0
        let password = passwordTextFiled.text ?? ""
        let repeatPass = repeatPasswordTextFiled.pureText
        let passess = (password.count > 0) && (password == repeatPass)
        let clarification = clarificationCheckBox.isSelected
        let consent = consentCheckBox.isSelected
        signupButton.isEnabled = name && phone && email && tcTax && license && passess && clarification && consent
    }
    
    @objc func editingChanged(_ textField: UITextField) {
       setButtonActivation()
    }
    
    @IBAction func didTapClarificationCheckBox(_ sender: UIButton) {
        clarificationCheckBox.isSelected = !clarificationCheckBox.isSelected
        setButtonActivation()
    }
    
    @IBAction func didTapConsentCheckBox(_ sender: UIButton) {
        consentCheckBox.isSelected = !consentCheckBox.isSelected
        setButtonActivation()
    }
    
    @IBAction func didTapMarketingCheckBox(_ sender: UIButton) {
        marketingCheckBox.isSelected = !marketingCheckBox.isSelected
        
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        viewModel.signup(name: nameTextField.text ?? "",
                         phone: phoneTextField.text ?? "",
                         email: emailTextFiled.text ?? "",
                         id: idTextField.text ?? "",
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
