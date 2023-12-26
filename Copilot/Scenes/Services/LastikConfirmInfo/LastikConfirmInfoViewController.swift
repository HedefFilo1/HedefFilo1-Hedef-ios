//
//  LastikConfirmInfoViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/26/23.
//

import Foundation
import UIKit

class LastikConfirmInfoViewController: UIViewController {
    
    var viewModel: LastikConfirmInfoViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pointsView: LastikPointsView!
    @IBOutlet weak var descriptionLabel: UILabel!
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
        pointsView.imageView.image = Images.lastikPoints
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.blackS20B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.tireOperations
        descriptionLabel.text = Strings.lastikConfirmInfoText
        serviceButton.setTitle(Strings.proceedServiceSelection, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapService() {
        viewModel.goToServices()
    }
}

extension LastikConfirmInfoViewController: LastikConfirmInfoViewModelDelegate {
    
}
