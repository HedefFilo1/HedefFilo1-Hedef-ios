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
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var uppercaseLabel: UILabel!
    @IBOutlet weak var lowercaseLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var specialLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    
    private var clarfication: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        APIService.addUserAction(pageName: "Sign up", actionName: "LOGIN_PAGE_LOAD_SIGN_UP")
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
        nameTextField.delegate = self
        surnameTextField.delegate = self
        taxTextField.delegate = self
        licenseTextField.delegate = self
        plateNumberTextField.delegate = self
    }
    
    func setTextFieldsRelations() {
        var previouses: [CPValidatableTextField] = [nameTextField]
        surnameTextField.previousReqiredFields = previouses
        previouses.append(surnameTextField)
        phoneTextField.previousReqiredFields = previouses
        previouses.append(phoneTextField)
        emailTextFiled.previousReqiredFields = previouses
        previouses.append(emailTextFiled)
        taxTextField.previousReqiredFields = previouses
        previouses.append(taxTextField)
        plateNumberTextField.previousReqiredFields = previouses
        previouses.append(plateNumberTextField)
        licenseTextField.previousReqiredFields = previouses
        previouses.append(licenseTextField)
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
        
        isMemberLabel.apply(.greyS16R400)
        loginButton.apply(.themeS16B700)
        
        minLabel.apply(.greyS12R400)
        uppercaseLabel.apply(.greyS12R400)
        lowercaseLabel.apply(.greyS12R400)
        numberLabel.apply(.greyS12R400)
        specialLabel.apply(.greyS12R400)
        warningLabel.apply(.custom(.theme, .medium, 12))
    }
    
    func setTexts() {
        descriptionLabel.text = App.getString(key: "copilotapp.sign.up.title")
        nameTextField.placeholder = App.getString(key: "copilotapp.sign.up.name.input.description")
        surnameTextField.placeholder = App.getString(key: "copilotapp.sign.up.surname.input.description")
        phoneTextField.placeholder = App.getString(key: "copilotapp.sign.up.phone.input.description")
        emailTextFiled.placeholder = App.getString(key: "copilotapp.sign.in.email.input.description")
        taxTextField.placeholder = App.getString(key: "copilotapp.sign.up.tax.number.input.description")
        plateNumberTextField.placeholder = App.getString(key: "copilotapp.sign.up.plate.input.description")
        licenseTextField.placeholder = App.getString(key: "copilotapp.sign.up.vehicle.licence.input.description")
        passwordTextFiled.placeholder = App.getString(key: "copilotapp.sign.in.password.input.description")
        repeatPasswordTextFiled.placeholder = App.getString(key: "copilotapp.sign.up.password.again.input.description")
        setClarificationText()
        marketingLabel.text = App.getString(key: "copilotapp.sign.up.checkbox.two.description")
        signupButton.setTitle(App.getString(key: "copilotapp.sign.up.button"), for: .normal)
        
        isMemberLabel.text = App.getString(key: "copilotapp.sign.up.bottom.button.description")
        clarificationErrorView.message = Strings.clarificationError
        smsLabel.text = App.getString(key: "copilotapp.sign.up.checkbox.three.description")
        telephoneLabel.text = App.getString(key: "copilotapp.sign.up.checkbox.four.description")
        emailLabel.text = App.getString(key: "copilotapp.sign.up.checkbox.five.description")
        
        loginButton.setAttributedTitle(App.getString(key: "copilotapp.sign.up.bottom.button")?.underLined, for: .normal)
        setTextFieldWarnings()
        let minText = App.getString(key: "copilotapp.sign.up.password.warning.one") ?? ""
        minLabel.text = "*\(minText)"
        let uppercase = App.getString(key: "copilotapp.sign.up.password.warning.two") ?? ""
        uppercaseLabel.text = "*\(uppercase)"
        let lowercase = App.getString(key: "copilotapp.sign.up.password.warning.three") ?? ""
        lowercaseLabel.text = "*\(lowercase)"
        let number = App.getString(key: "copilotapp.sign.up.password.warning.four") ?? ""
        numberLabel.text = "*\(number)"
        let special = App.getString(key: "copilotapp.sign.up.password.warning.five") ?? ""
        specialLabel.text = "*\(special)"
        warningLabel.text = App.getString(key: "copilotapp.login.information.message")
    }
    
    func setClarificationText(color: UIColor = .textGrey) {
        let text1 = App.getString(key: "copilotapp.sign.up.checkbox.one.button") ?? ""
        let text2 = App.getString(key: "copilotapp.sign.up.checkbox.one.description") ?? ""
        let text3 = text1 + " " + text2
        let calrification = AttributedText(text: text3, fontSize: 12, style: .regular, textColor: color)
        let calrificationUnderlined = AttributedText(text: text1, fontSize: 12, style: .bold, textColor: color)
        clarificationLabel.attributedText = AttributedText.createUnderlinedString(mainText: calrification, underlinedText: calrificationUnderlined)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClarificationLabel(tap:)))
        self.clarificationLabel.addGestureRecognizer(tap)
        self.clarificationLabel.isUserInteractionEnabled = true
    }
    
    @objc func tapClarificationLabel(tap: UITapGestureRecognizer) {
        
        let text = clarificationLabel.text
        let findText = App.getString(key: "copilotapp.sign.up.checkbox.one.button") ?? ""
        if let range = (text as? NSString)?.range(of: findText) {
            if tap.didTapAttributedTextInLabel(label: self.clarificationLabel, inRange: range) {
                if !clarificationCheckBox.isSelected {
                    viewModel.openClarification()
                }
            }
        }
        didTapClarificationCheckBox(UIButton())
    }
    
    func setTextFieldWarnings() {
        nameTextField.errorMessage = Strings.nameInputError
        surnameTextField.errorMessage = Strings.surnameInputError
        taxTextField.errorMessage = Strings.taxInputError
        plateNumberTextField.errorMessage = Strings.plateNumberInputError
        licenseTextField.errorMessage = Strings.licenseNumberInputError
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

extension SignupViewController: SignupViewModelDelegate {
    
}
