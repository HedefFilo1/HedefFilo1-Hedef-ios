//
//  ContractAgreementViewController.swift
//  Copilot
//
//  Created by Jamal on 3/12/24.
//

import Foundation
import UIKit

class ContractAgreementViewController: UIViewController {
    
    var viewModel: ContractAgreementViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        APIService.addUserAction(pageName: "Settings", actionName: "SETTING_CONFIDENTIALITY_AGREEMENT")
        textView.isEditable = false
        textView.text = App.getString(key: "copilotapp.help.confidentiality.agreement")
        textView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        textView.isEditable = false
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS24B700)
        textView.apply(.greyS14R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.confidentialityAgreement
        
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
  
}

extension ContractAgreementViewController: ContractAgreementViewModelDelegate {
    
}
