//
//  PasswordResetViewController.swift
//  Copilot
//
//  Created by Jamal on 10/29/23.
//

import Foundation
import UIKit

class PasswordResetViewController: UIViewController {
    
    var viewModel: PasswordResetViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var oldPasswordTextField: CPPasswordTextField!
    @IBOutlet weak var newPasswordTextField: CPPasswordTextField!
    @IBOutlet weak var repeatPasswordTextField: CPPasswordTextField!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var uppercaseLabel: UILabel!
    @IBOutlet weak var lowercaseLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var specialLabel: UILabel!
    @IBOutlet weak var saveButton: CPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        hideTabbarView()
        
#if DEV_DEBUG
        // just for test
//        viewModel.goToMain()
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
        saveButton.isEnabled = false
        oldPasswordTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        newPasswordTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        newPasswordTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        repeatPasswordTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backImageView.image = backImageView.image?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = .lightBlack
        titleLabel.apply(.blackS20B700)
        minLabel.apply(.greyS12R400)
        uppercaseLabel.apply(.greyS12R400)
        lowercaseLabel.apply(.greyS12R400)
        numberLabel.apply(.greyS12R400)
        specialLabel.apply(.greyS12R400)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.profile.password.renewal")
        oldPasswordTextField.placeholder = App.getString(key: "copilotapp.profile.password.renewal.input.title")
        newPasswordTextField.placeholder = App.getString(key: "copilotapp.profile.password.renewal.new.password.title")
        repeatPasswordTextField.placeholder = App.getString(key: "copilotapp.profile.password.renewal.new.password.again.title")
        let minText = App.getString(key: "copilotapp.profile.password.warning.one") ?? ""
        minLabel.text = "*\(minText)"
        let uppercase = App.getString(key: "copilotapp.profile.password.warning.two") ?? ""
        uppercaseLabel.text = "*\(uppercase)"
        let lowercase = App.getString(key: "copilotapp.profile.password.warning.three") ?? ""
        lowercaseLabel.text = "*\(lowercase)"
        let number = App.getString(key: "copilotapp.profile.password.warning.four") ?? ""
        numberLabel.text = "*\(number)"
        let special = App.getString(key: "copilotapp.profile.password.warning.five") ?? ""
        specialLabel.text = "*\(special)"
        saveButton.setTitle(App.getString(key: "copilotapp.profile.password.renewal.button"), for: .normal)
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
    
    @IBAction func didTapSave(_ sender: UIButton) {
        APIService.addUserAction(pageName: "PROFILE", actionName: "PROFILE_PASSWORD_CHANGE_CLICK")
        viewModel.setPassword(old: oldPasswordTextField.pureText,
                              new: newPasswordTextField.pureText)
    }
    
    @objc func editingDidEnd(_ textField: UITextField) {
        let repeatPass = repeatPasswordTextField.text ?? ""
        if textField == newPasswordTextField, repeatPass.count > 0 {
            checkPasswords()
        }
        if textField == repeatPasswordTextField {
            checkPasswords()
        }
    }
    
    func checkPasswords() {
        let pass = newPasswordTextField.text ?? ""
        let repeatPass = repeatPasswordTextField.text ?? ""
        if pass != repeatPass {
            repeatPasswordTextField.showError(message: Strings.passwordsShouldBeSame)
        } else {
            repeatPasswordTextField.hideError()
        }
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        let new = newPasswordTextField.text ?? ""
        let old = oldPasswordTextField.textCount > 0
        let repeatPass = repeatPasswordTextField.text ?? ""
        let same = new == repeatPass
        if textField == newPasswordTextField {
            checkRules()
        }
        
        if textField == newPasswordTextField || textField == repeatPasswordTextField {
            checkPasswords()
        }
        saveButton.isEnabled = viewModel.allRules && old && same
    }
    
    func checkRules() {
        let new = newPasswordTextField.text ?? ""
        viewModel.check(password: new)
        minLabel.textColor = viewModel.min8Rule ? .textSuccess: .theme
        uppercaseLabel.textColor = viewModel.uppercaseRule ? .textSuccess: .theme
        lowercaseLabel.textColor = viewModel.lowercaseRule ? .textSuccess: .theme
        numberLabel.textColor = viewModel.numberRule ? .textSuccess: .theme
        specialLabel.textColor = viewModel.specialRule ? .textSuccess: .theme
    }
}

extension PasswordResetViewController: PasswordResetViewModelDelegate {
    
}
