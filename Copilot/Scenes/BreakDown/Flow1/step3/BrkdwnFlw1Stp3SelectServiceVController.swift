//
//  BrkdwnFlw1Stp3SelectServiceVController.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation
import UIKit

class BrkdwnFlw1Stp3SelectServiceVController: UIViewController {
    
    var viewModel: BrkdwnFlw1Stp3SelectServiceViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var serviceButton: CPLightButton!
    
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
//        pointsView.imageView.image = Images.lastikPoints
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.blackS20B700)
        secondLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.breakDownOperations
        descriptionLabel.text = Strings.getWellSoonDoNotStart
        secondLabel.text = Strings.towTruckSendingDescription
        serviceButton.setTitle(Strings.proceedServiceSelection, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapService() {
        viewModel.goToServices()
    }
}

extension BrkdwnFlw1Stp3SelectServiceVController: BrkdwnFlw1Stp3SelectServiceVMDelegate {
    
}
