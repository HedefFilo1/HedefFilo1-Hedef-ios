//
//  Flow1Step3TireTypes.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation
import UIKit

class Flow1Step3TireTypesViewController: UIViewController {
    
    var viewModel: Flow1Step3TireTypesViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var summerButton: CPLightButton!
    @IBOutlet weak var winterButton: CPLightButton!
    
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
        descriptionLabel.apply(.blackS14R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.tireOperations
        descriptionLabel.text = Strings.requestLastkFromMangerText
        summerButton.setTitle(Strings.submitSummerTireRequest, for: .normal)
        winterButton.setTitle(Strings.submitWinterTireRequest, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapSummer() {
        viewModel.requestTire(tireType: TireSupportType.newSummer)
    }
    
    @IBAction func didTapWinter() {
        viewModel.requestTire(tireType: TireSupportType.newWinter)
    }
}

extension Flow1Step3TireTypesViewController: Flow1Step3TireTypesViewModelDelegate {
    
}