//
//  KMUsedViewController.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import Foundation
import UIKit

class KMUsedViewController: SheetViewController {
    
    var viewModel: KMUsedViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 214
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kmTextField: CPTextField!
    @IBOutlet weak var saveButton: CPButton!
    
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
        viewModel.dismiss()
    }
}

extension KMUsedViewController: KMUsedViewModelDelegate {
    
}