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
    @IBOutlet weak var saveButton: CPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
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
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backImageView.image = backImageView.image?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = .lightBlack
        titleLabel.apply(.blackS20B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.resetPassword
        oldPasswordTextField.placeholder = Strings.oldPassword
        newPasswordTextField.placeholder = Strings.newPassword
        repeatPasswordTextField.placeholder = Strings.repeatPasswordAgain
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
    
    @IBAction func didTapSave(_ sender: UIButton) {
        
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        let new = newPasswordTextField.textCount > 0
        let old = oldPasswordTextField.textCount > 0
        let repeatPass = repeatPasswordTextField.textCount > 0
        saveButton.isEnabled = new && old && repeatPass
    }
}

extension PasswordResetViewController: PasswordResetViewModelDelegate {
    
}