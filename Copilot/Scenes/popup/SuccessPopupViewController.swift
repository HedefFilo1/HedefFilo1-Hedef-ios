//
//  SuccessPopupViewController.swift
//  Copilot
//
//  Created by Jamal on 10/5/23.
//

import Foundation
import UIKit

protocol MessagePopupViewControllerDelegate: AnyObject {
    func didDismiss(_: SuccessPopupViewController?)
}

class SuccessPopupViewController: PopupViewController {
    
    var titleText = ""
    var message = ""
    var buttonTitle = ""
    
    var attributedMessage: NSAttributedString?
    var color = UIColor.textSuccess
    var icon = Images.tikIcon
    weak var delegate: MessagePopupViewControllerDelegate?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button: CPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setTexts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupUI() {
        button.isEnabled = true
        button.isSmallFontSize = true
        applyStyles()
        
    }
    
    private func applyStyles() {
        contentView.layer.cornerRadius = 10
        circleView.layer.cornerRadius = 40
        circleView.backgroundColor = color
        iconImageView.image = icon
        iconImageView.tintColor = .white
        titleLabel.apply(.blackS16B700)
        messageLabel.apply(.greyS16B400)
    }
    
    func setTexts() {
        titleLabel.text = titleText
        
        if let attributedMessage = attributedMessage {
            messageLabel.attributedText = attributedMessage
        } else {
            messageLabel.text = message
        }
        
        button.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.didDismiss(nil)
        }
    }
    
}
