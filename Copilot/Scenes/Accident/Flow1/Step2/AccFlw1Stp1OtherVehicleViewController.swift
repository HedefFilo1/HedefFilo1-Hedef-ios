//
//  AccFlw1Stp1OtherVehicleViewController.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import UIKit

class AccFlw1Stp2OtherVehicleViewController: UIViewController {
    
    var viewModel: AccFlw1Stp2OtherVehicleViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var questonLabel: UILabel!
    @IBOutlet weak var yesButton: CPLightButton!
    @IBOutlet weak var noButton: CPLightButton!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var guidLabel: UILabel!
    
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
        descriptionLabel.apply(.greyS14R400)
        questonLabel.apply(.blackS20B700)
        footerLabel.apply(.greyS12R400)
        guidLabel.apply(.themeS14B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.accidentOperations
        descriptionLabel.text = Strings.getWellAndFillInfo
        yesButton.setTitle(Strings.yesThereIs, for: .normal)
        noButton.setTitle(Strings.noThereIsNot, for: .normal)
        footerLabel.text = Strings.getInfoAfter
        guidLabel.text = Strings.goToAccidentGuide
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapYes() {
        viewModel.goToAccFlw1Stp3Agreement()
    }
    
    @IBAction func didTapNo() {
        viewModel.goToAccFlw5Stp3Declare()
    }

}

extension AccFlw1Stp2OtherVehicleViewController: AccFlw1Stp2OtherVehicleViewModelDelegate {
    
}
