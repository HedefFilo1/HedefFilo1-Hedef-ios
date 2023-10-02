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
        
#if DEV_DEBUG
        // just for test
        viewModel.goToNextScene()
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if App.appLoaded == false {
            App.appLoaded = true
        }
        
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
        countryLabel.apply(.greyS12B400)
        descriptionLabel.apply(.blackS16M500)
        
        rememberLabel.apply(.greyS12B400)
        forgotPasswordButton.apply(.blackS12R400)
        notMemberLabel.apply(.greyS16B400)
        becomeMemberButton.apply(.themeS16B700)
    }
    
    func setTexts() {
        descriptionLabel.text = Strings.loginDescription
        rememberLabel.text = Strings.rememberMe
        forgotPasswordButton.setAttributedTitle(Strings.forgotMyPassword.underLined, for: .normal)
        loginButton.setTitle(Strings.login, for: .normal)
        notMemberLabel.text = Strings.ifNotMember
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
                        password: passwordTextFiled.text ?? "")
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
}
