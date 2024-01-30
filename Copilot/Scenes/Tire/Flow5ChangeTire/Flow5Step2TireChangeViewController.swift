//
//  LastikChangeViewController.swift
//  Copilot
//
//  Created by Jamal on 1/23/24.
//

import Foundation
import UIKit

class Flow5Step2TireChangeViewController: UIViewController {
    
    var viewModel: Flow5Step2TireChangeViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heffolioButton: CPLightButton!
    @IBOutlet weak var myselfButton: CPLightButton!
    
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
        descriptionLabel.apply(.blackS20B700)
        
        heffolioButton.titleLabel?.numberOfLines = 0
        heffolioButton.titleLabel?.textAlignment = .center
        
        myselfButton.titleLabel?.numberOfLines = 0
        myselfButton.titleLabel?.textAlignment = .center
    }
    
    func setTexts() {
        titleLabel.text = Strings.tireOperations
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapHeddefolio() {
        viewModel.goToServiceDetail()
    }
    
    @IBAction func didTapMySelf() {
        viewModel.goToServices()
    }
}

extension Flow5Step2TireChangeViewController: Flow5Step2TireChangeViewModelDelegate {
    
}
