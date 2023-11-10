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
    
    @IBOutlet weak var nameTextField: CPValidatableTextField!
    @IBOutlet weak var surnameTextField: CPValidatableTextField!
    @IBOutlet weak var phoneTextField: CPPhoneTextField!
    @IBOutlet weak var emailTextFiled: CPEmailTextField!
    @IBOutlet weak var taxTextField: CPValidatableTextField!
    @IBOutlet weak var plateNumberTextField: CPValidatableTextField!
    @IBOutlet weak var licenseTextField: CPValidatableTextField!
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
        
        setTextFieldsEvents()
        setTextFieldsKeyboards()
        setTextFieldsDelegates()
        setTextFieldsRelations()
        signupButton.isEnabled = false
        clarificationErrorView.isHidden = true
    }
    
    func setTextFieldsEvents() {
        nameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        surnameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        emailTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        taxTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        plateNumberTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        licenseTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        repeatPasswordTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        repeatPasswordTextFiled.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    func setTextFieldsKeyboards() {
        phoneTextField.keyboardType = .phonePad
        taxTextField.keyboardType = .numberPad
        plateNumberTextField.keyboardType = .namePhonePad
        licenseTextField.keyboardType = .namePhonePad
        plateNumberTextField.autocapitalizationType = .allCharacters
        licenseTextField.autocapitalizationType = .allCharacters
    }
    
    func setTextFieldsDelegates() {
        nameTextField.validationDelegate = self
        surnameTextField.validationDelegate = self
        taxTextField.validationDelegate = self
        plateNumberTextField.validationDelegate = self
        licenseTextField.validationDelegate = self
        
        taxTextField.delegate = self
        licenseTextField.delegate = self
        plateNumberTextField.delegate = self
    }
    
    func setTextFieldsRelations() {
        var previouses: [CPValidatableTextField] = [nameTextField]
        surnameTextField.previousReqiredFields = previouses
        previouses.append(surnameTextField)
        phoneTextField.previousReqiredFields = previouses
        emailTextFiled.previousReqiredFields = previouses
        taxTextField.previousReqiredFields = previouses
        plateNumberTextField.previousReqiredFields = previouses
        licenseTextField.previousReqiredFields = previouses
        passwordTextFiled.previousReqiredFields = previouses
        repeatPasswordTextFiled.previousReqiredFields = previouses
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
        nameTextField.placeholder = Strings.name
        surnameTextField.placeholder = Strings.surname
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
        setTextFieldWarnings()
    }
    
    func setClarificationText(color: UIColor = .textGrey) {
        let calrification = AttributedText(text: Strings.clarificationDescription, fontSize: 12, style: .regular, textColor: color)
        let calrificationUnderlined = AttributedText(text: Strings.clarificationText, fontSize: 12, style: .bold, textColor: color)
        clarificationLabel.attributedText = AttributedText.createUnderlinedString(mainText: calrification, underlinedText: calrificationUnderlined)
    }
    
    func setTextFieldWarnings() {
        nameTextField.errorMessage = Strings.nameInputError
        surnameTextField.errorMessage = Strings.surnameInputError
        taxTextField.errorMessage = Strings.taxInputError
        plateNumberTextField.errorMessage = Strings.plateNumberInputError
        licenseTextField.errorMessage = Strings.licenseNumberInputError
    }
    
    func setButtonActivation() {
        let name = nameTextField.validate()
        let surname = surnameTextField.validate()
        let phone = phoneTextField.validate()
        let email = emailTextFiled.validate()
        let tcTax = taxTextField.validate()
        let plate = plateNumberTextField.validate()
        let license = licenseTextField.validate()
        let pass = passwordTextFiled.text ?? ""
        let repeatPass = repeatPasswordTextFiled.text ?? ""
        let passes = pass.count > 0 && repeatPass.count > 0 && pass == repeatPass
        let clarification = clarificationCheckBox.isSelected
        signupButton.isEnabled = name && surname && phone && email && tcTax && plate && license && passes && clarification
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField == plateNumberTextField || textField == licenseTextField {
            textField.text = textField.text?.uppercased()
        }
        if textField == repeatPasswordTextFiled {
            let pass = passwordTextFiled.text ?? ""
            let repeatPass = repeatPasswordTextFiled.text ?? ""
            if pass == repeatPass {
                repeatPasswordTextFiled.hideError()
            }
        }
        setButtonActivation()
    }
    
    @objc func editingDidEnd(_ textField: UITextField) {
        let repeatPass = repeatPasswordTextFiled.text ?? ""
        if textField == passwordTextFiled, repeatPass.count > 0 {
            checkPasswords()
        }
        if textField == repeatPasswordTextFiled {
            checkPasswords()
        }
    }
    
    func checkPasswords() {
        let pass = passwordTextFiled.text ?? ""
        let repeatPass = repeatPasswordTextFiled.text ?? ""
        if pass != repeatPass {
            repeatPasswordTextFiled.showError(message: Strings.passwordsShouldBeSame)
        } else {
            repeatPasswordTextFiled.hideError()
        }
    }
    
    @IBAction func didTapClarificationCheckBox(_ sender: UIButton) {
        clarificationCheckBox.isSelected = !clarificationCheckBox.isSelected
        
        if clarificationCheckBox.isSelected {
            clarificationErrorView.isHidden = true
            setClarificationText()
        } else {
            clarificationErrorView.isHidden = false
            setClarificationText(color: .theme)
        }
        setButtonActivation()
    }
    
    @IBAction func didTapMarketingCheckBox(_ sender: UIButton) {
        marketingCheckBox.isSelected = !marketingCheckBox.isSelected
        smsCheckBox.isSelected = marketingCheckBox.isSelected
        telephoneCheckBox.isSelected = marketingCheckBox.isSelected
        emailCheckBox.isSelected = marketingCheckBox.isSelected
    }
    
    func checkMarketingCheckBox() {
        if !smsCheckBox.isSelected && !telephoneCheckBox.isSelected && !emailCheckBox.isSelected {
            marketingCheckBox.isSelected = false
        }
    }
    
    @IBAction func didTapSMSCheckBox(_ sender: UIButton) {
        smsCheckBox.isSelected = !smsCheckBox.isSelected
        checkMarketingCheckBox()
    }
    
    @IBAction func didTapTelephoneCheckBox(_ sender: UIButton) {
        telephoneCheckBox.isSelected = !telephoneCheckBox.isSelected
        checkMarketingCheckBox()
    }
    
    @IBAction func didTapEmailCheckBox(_ sender: UIButton) {
        emailCheckBox.isSelected = !emailCheckBox.isSelected
        checkMarketingCheckBox()
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        let clarification = clarificationCheckBox.isSelected
        clarificationErrorView.isHidden = clarification
        
        if !clarification {
            setClarificationText(color: .theme)
            return
        }
        let phone = telephoneCheckBox.isSelected
        let sms = smsCheckBox.isSelected
        let email = emailCheckBox.isSelected
        
        viewModel.signup(name: nameTextField.text ?? "",
                         surname: surnameTextField.text ?? "",
                         phone: phoneTextField.text ?? "",
                         email: emailTextFiled.text ?? "",
                         taxId: taxTextField.text ?? "",
                         plateNumber: plateNumberTextField.text ?? "",
                         licence: licenseTextField.text ?? "",
                         password: passwordTextFiled.text ?? "",
                         phonePermission: phone,
                         smsPermission: sms,
                         emailPermission: email)
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        viewModel.goToLogin()
    }
}

extension SignupViewController: CPValidatableTextFieldDelegate, UITextFieldDelegate {
    
    func validate(textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            return nameTextField.pureTextCount > 0
            
        case surnameTextField:
            return surnameTextField.pureTextCount > 0
            
        case taxTextField:
            return taxTextField.textCount == 10
            
        case plateNumberTextField:
            let count = plateNumberTextField.pureTextCount
            return count == 7 || count == 8
            
        case licenseTextField:
            let text = licenseTextField.pureText
            let letters = String(text.prefix(2))
            let numbers = text.replacingOccurrences(of: letters, with: "")
            return numbers.isNumber && letters.isLetterString && text.count == 8
            
        default:
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        
        if textField == licenseTextField || textField == plateNumberTextField {
            return range.location < 8
        }
        return range.location < 10
    }
}

extension SignupViewController: SignupViewModelDelegate {
    
}
