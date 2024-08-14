//
//  LoginViewController.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var emailTextFiled: CPEmailTextField!
    @IBOutlet weak var passwordTextFiled: CPPasswordTextField!
    @IBOutlet weak var rememberCheckBox: CPCheckBox!
    @IBOutlet weak var rememberLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: CPLightButton!
    @IBOutlet weak var notMemberLabel: UILabel!
    @IBOutlet weak var becomeMemberButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
#if DEV_DEBUG || DEV_PROD
        // just for test
//        viewModel.goToNextScene(email: "jamal.zare@solidict.com")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTwice))
        tap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(didTapTripple))
        tap2.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap2)
        
        let button = UIButton()
        view.addSubview(button)
        button.align(top: 250, width: 170, height: 40, centerX: 0)
        button.addTarget(self, action: #selector(loginMyAccount), for: .touchUpInside)
        button.setTitle("Login My Account", for: .normal)
        button.backgroundColor = .systemYellow
//        button.isHidden = true
        
        let button2 = UIButton()
        view.addSubview(button2)
        button2.align(top: 300, width: 170, height: 40, centerX: 0)
        button2.addTarget(self, action: #selector(ozlemLogin), for: .touchUpInside)
        button2.setTitle("Ozlem", for: .normal)
        button2.backgroundColor = .systemOrange
#endif
    }
    
    @objc func didTapTwice() {
        viewModel.goToNextScene(email: "jamal.zare@solidict.com")
    }
    
    @objc func didTapTripple() {
        emailTextFiled.preText = "ezgiakcay@hedeffilo.com"
        passwordTextFiled.preText = "Helen1234."
    }
    
    @objc func loginMyAccount() {
//        viewModel.login(email: "jamal.zare@solidict.com",
//                        password: "Jj_123456",
//                        rememberMe: rememberCheckBox.isSelected)
        
//        viewModel.login(email: "yunus.simsiki@solidict.com",
//                        password: "asd",
//                        rememberMe: rememberCheckBox.isSelected)
        
        viewModel.login(email: "okanukic@hotmail.com",
                        password: "asd",
                        rememberMe: rememberCheckBox.isSelected)
    }
   
    @objc func ozlemLogin() {
        viewModel.login(email: "ozlem.erdem@hedeffilo.com",
                        password: "tXAya133",
                        rememberMe: rememberCheckBox.isSelected)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkRememberMe()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        clearInputs()
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        emailTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        loginButton.isEnabled = false
    }
    
    func applyStyle() {
        countryCodeView.layer.cornerRadius = 6
        countryCodeView.layer.borderWidth = 1
        countryCodeView.layer.borderColor = UIColor.textGrey.cgColor
        countryLabel.apply(.greyS12R400)
        descriptionLabel.apply(.blackS16M500)
        
        rememberLabel.apply(.greyS12R400)
        forgotPasswordButton.apply(.blackS12R400)
        notMemberLabel.apply(.greyS16R400)
        becomeMemberButton.apply(.themeS16B700)
    }
    
    func setTexts() {
        descriptionLabel.text = App.getString(key: "copilotapp.sign.in.title")
        rememberLabel.text = App.getString(key: "copilotapp.sign.in.remember.button")
        forgotPasswordButton.setAttributedTitle(App.getString(key: "copilotapp.sign.in.forgot.password.button")?.underLined, for: .normal)
        loginButton.setTitle(App.getString(key: "copilotapp.sign.up.bottom.button"), for: .normal)
        notMemberLabel.text = App.getString(key: "copilotapp.onboarding.four.bottom.description")
        becomeMemberButton.setAttributedTitle(Strings.becomeMember.underLined, for: .normal)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        let email = emailTextFiled.validate()
        let password = passwordTextFiled.pureTextCount > 0
        loginButton.isEnabled = email && password
    }
    
    @IBAction func didTapCheckBox(_ sender: UIButton) {
        rememberCheckBox.isSelected = !rememberCheckBox.isSelected
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        viewModel.goToForgotPassword()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        viewModel.login(email: emailTextFiled.text ?? "",
                        password: passwordTextFiled.text ?? "",
                        rememberMe: rememberCheckBox.isSelected)
    }
    
    @IBAction func didTapSignup(_ sender: Any) {
        viewModel.goToSignup()
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func set(email: String, password: String) {
        emailTextFiled.preText = email
        passwordTextFiled.preText = password
        rememberCheckBox.isSelected = true
    }
    
    func clearInputs() {
//        emailTextFiled.preText = ""
//        passwordTextFiled.preText = ""
//        emailTextFiled.hideError()
    }
}
