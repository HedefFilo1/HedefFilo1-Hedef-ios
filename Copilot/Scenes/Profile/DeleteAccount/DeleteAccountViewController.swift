//
//  DeleteAccountViewController.swift
//  Copilot
//
//  Created by Jamal on 8/9/24.
//

import Foundation
import UIKit

class DeleteAccountViewController: SheetViewController {
    
    var viewModel: DeleteAccountViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 252
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var confirmButton: CPButton!
    @IBOutlet weak var cancelButton: CPLightButton!
    @IBOutlet weak var loadingContainer: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        confirmButton.isEnabled = true
    }
    
    func applyStyle() {
//        view.backgroundColor = .white
        titleLabel.apply(.blackS18B700)
        titleLabel.textAlignment = .center
        descriptionLabel.apply(.blackS16B700)
        descriptionLabel.textAlignment = .center
    }
    
    func setTexts() {
        titleLabel.text = Strings.confirm
        descriptionLabel.text = Strings.deleteAccountDescription
        confirmButton.setTitle(Strings.confirm, for: .normal)
        cancelButton.setTitle(Strings.cancel, for: .normal)
    }
    
    @IBAction func didTapConfirm() {
        Loading.shared.show(presentingView: loadingContainer)
        viewModel.deleteAccount()
    }
    
    @IBAction func didTapClose() {
        dismiss(animated: true)
    }

}

extension DeleteAccountViewController: DeleteAccountViewModelDelegate {
    func didDeleteAccount() {
        didTapClose()
    }
}
