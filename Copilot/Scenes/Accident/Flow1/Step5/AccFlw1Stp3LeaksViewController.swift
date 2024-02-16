//
//  AccFlw1Stp5LeaksViewController.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import UIKit

class AccFlw1Stp5LeaksViewController: UIViewController {
    
    var viewModel: AccFlw1Stp5LeaksViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
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
        questonLabel.apply(.blackS20B700)
    }
    
    func setTexts() {
        questonLabel.text = Strings.areThereAnyFluidLeaks
        yesButton.setTitle(Strings.yesThereIs, for: .normal)
        noButton.setTitle(Strings.noThereIsNot, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapYes() {
        
    }
    
    @IBAction func didTapNo() {
        
    }

}

extension AccFlw1Stp5LeaksViewController: AccFlw1Stp5LeaksViewModelDelegate {
    
}
