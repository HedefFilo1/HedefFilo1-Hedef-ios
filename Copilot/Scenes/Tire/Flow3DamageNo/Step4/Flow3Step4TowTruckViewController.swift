//
//  Flow3Step4TowTruck.swift
//  Copilot
//
//  Created by Jamal on 1/29/24.
//

import Foundation
import UIKit

class Flow3Step4TowTruckViewController: UIViewController {
    
    var viewModel: Flow3Step4TowTruckViewModelType! {
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
        titleLabel.text = Strings.tireOperations
        descriptionLabel.text = App.getString(key: "copilotapp.servicetire.tire.operation.take.paid.tow.truck.get.well.soon.title")
        secondLabel.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.warning.light.chosen.service.list")
        serviceButton.setTitle(App.getString(key: "copilotapp.servicetire.tire.operation.take.paid.tow.truck.get.well.soon.proceed.service.selection.button"), for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapService() {
        viewModel.goToServices()
    }
}

extension Flow3Step4TowTruckViewController: Flow3Step4TowTruckViewModelDelegate {
    
}
