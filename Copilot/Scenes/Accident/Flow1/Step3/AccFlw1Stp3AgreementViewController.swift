//
//  AccFlw1Stp3AgreementViewController.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import UIKit

class AccFlw1Stp3AgreementViewController: UIViewController {
    
    var viewModel: AccFlw1Stp3AgreementViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var questonLabel: UILabel!
    @IBOutlet weak var yesButton: CPLightButton!
    @IBOutlet weak var noButton: CPLightButton!
    @IBOutlet weak var descriptionLabel: UILabel!
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
        questonLabel.apply(.blackS20B700)
        guidLabel.apply(.themeS14B700)
        descriptionLabel.apply(.greyS12R400)
    }
    
    func setTexts() {
        questonLabel.text = Strings.wereYouAbleAgreement
        yesButton.setTitle(Strings.weAgreed, for: .normal)
        noButton.setTitle(Strings.weCouldntAgreed, for: .normal)
        descriptionLabel.text = Strings.getInfoAfter
        guidLabel.text = Strings.goToAccidentGuide
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapYes() {
        AccidentCoordinator.accidentReportType = .ANLASMALI_TUTANAK
        viewModel.goToAccFlw1Stp4Report()
    }
    
    @IBAction func didTapNo() {
        AccidentCoordinator.accidentReportType = .ZABIT
        viewModel.goToAccFlw4Stp4NoAgreement()
    }

}

extension AccFlw1Stp3AgreementViewController: AccFlw1Stp3AgreementViewModelDelegate {
    
}
