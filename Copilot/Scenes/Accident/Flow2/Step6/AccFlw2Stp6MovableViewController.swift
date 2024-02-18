//
//  AccFlw2Stp6MovableViewController.swift
//  Copilot
//
//  Created by Jamal on 2/18/24.
//

import Foundation
import UIKit

class AccFlw2Stp6MovableViewController: UIViewController {
    
    var viewModel: AccFlw2Stp6MovableViewModelType! {
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
        questonLabel.text = Strings.isVehicleMovable
        yesButton.setTitle(Strings.yesCanMove, for: .normal)
        noButton.setTitle(Strings.noCantMove, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapYes() {
        viewModel.goToServices()
    }
    
    @IBAction func didTapNo() {
        
    }

}

extension AccFlw2Stp6MovableViewController: AccFlw2Stp6MovableViewModelDelegate {
    
}
