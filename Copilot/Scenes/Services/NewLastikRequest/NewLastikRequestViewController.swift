//
//  NewLastikRequestViewController.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation
import UIKit

class NewLastikRequestViewController: UIViewController {
    
    var viewModel: NewLastikRequestViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var requestButton: CPLightButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        messageLabel.apply(.blackS16B700)
        descriptionLabel.apply(.blackS14R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.tireOperations
        messageLabel.text = Strings.notHaveRightToTire
        descriptionLabel.text = Strings.requestFromMangerText
        requestButton.setTitle(Strings.requestFromManger, for: .normal)
        
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapRequestNew() {
        viewModel.lastikFromManger()
    }
}

extension NewLastikRequestViewController: NewLastikRequestViewModelDelegate {
    
}