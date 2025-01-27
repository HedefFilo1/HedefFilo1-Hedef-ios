//
//  KMUsedViewController.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import Foundation
import UIKit

protocol KMUsedViewControllerDelegate: AnyObject {
    func reloadDistance()
}

class KMUsedViewController: SheetViewController {
    
    var viewModel: KMUsedViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    weak var delegate: KMUsedViewControllerDelegate?
    override var presentationHeight: CGFloat {
        return 214
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kmTextField: CPTextField!
    @IBOutlet weak var saveButton: CPButton!
    @IBOutlet weak var loadingContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        kmTextField.becomeFirstResponder()
    }
    
    func setupUI() {
        kmTextField.keyboardType = .numberPad
        kmTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        kmTextField.delegate = self
        applyStyle()
        setTexts()
        saveButton.isEnabled = false
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.kmUsed
        kmTextField.placeholder = Strings.enterUsedKM
        saveButton.setTitle(Strings.save, for: .normal)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        let count = textField.text?.count ?? 0
        saveButton.isEnabled = count > 0
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        viewModel.dismiss()
    }
    
    @IBAction func didTapSave(_ sender: UIButton) {
        if let distance = Double(kmTextField.pureText) {
            Loading.shared.show(presentingView: loadingContainer)
            viewModel.setDistance(distance: distance)
        }
    }
}

extension KMUsedViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
}

extension KMUsedViewController: KMUsedViewModelDelegate,
                                MessagePopupViewControllerDelegate {
    
    func didDismiss(_: SuccessPopupViewController?) {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.reloadDistance()
        }
    }
    
    func setDistance() {
        let title = App.getString(key: "copilotapp.homepage.success.km.ok.button") ?? ""
        let message = App.getString(key: "copilotapp.homepage.success.km") ?? ""
        showSuccess(successTitle: "", message: message, buttonTitle: title, delegate: self)
    }
}
