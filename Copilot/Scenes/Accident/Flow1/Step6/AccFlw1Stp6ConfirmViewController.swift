//
//  AccFlw1Stp6ConfirmViewController.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation
import UIKit

class AccFlw1Stp6ConfirmViewController: UIViewController {
    
    var viewModel: AccFlw1Stp6ConfirmViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questonLabel: UILabel!
    @IBOutlet weak var yesButton: CPLightButton!
    @IBOutlet weak var noButton: CPLightButton!
    
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
        questonLabel.apply(.blackS20B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.accidentOperations
        questonLabel.text = Strings.accidentTowTruckDescription
        yesButton.setTitle(Strings.yesAndAccept, for: .normal)
        noButton.setTitle(Strings.noDontAccept, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapYes() {
        
    }
    
    @IBAction func didTapNo() {
        viewModel.getBack()
    }

}

extension AccFlw1Stp6ConfirmViewController: AccFlw1Stp6ConfirmViewModelDelegate {
    
}
