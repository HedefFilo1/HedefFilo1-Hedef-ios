//
//  NotMaintenancePeriodViewController.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation
import UIKit

class NotMaintenancePeriodViewController: UIViewController {
    
    var viewModel: NotMaintenancePeriodViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var circleView: UILabel!
    @IBOutlet weak var closeIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var remainedKmLabel: UILabel!
    @IBOutlet weak var getBackButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        getBackButton.isEnabled = true
    }
    
    func applyStyle() {
        circleView.layer.cornerRadius = 40
        titleLabel.apply(.blackS18B700)
        periodLabel.apply(.blackS20B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.createMaintenanceAppointment
        periodLabel.text = Strings.accordingToVehiclePeriods
        kmLabel.text = Strings.vehicleMileage
        setPeriodLabels()
        getBackButton.setTitle(Strings.returnToHomePage, for: .normal)
    }
    
    func setPeriodLabels() {
        setAttributedText(label: daysLabel, title: Strings.timeToMaintenance, value: "365 Gün")
        let str = "\(viewModel.nextMaintenanceKm)".getFormattedIntNumber()
        setAttributedText(label: kmLabel, title: Strings.mileageToBeMaintained, value: "\(str) KM")
        let remaining = "\(viewModel.remainingKM)".getFormattedIntNumber()
        setAttributedText(label: remainedKmLabel, title: Strings.kmRemainingForMaintenance, value: "\(remaining) KM")
    }
    
    func setAttributedText(label: UILabel, title: String, value: String) {
        let title = [AttributedText(text: "\(title): ", type: .greyS12R400),
                     AttributedText(text: value, type: .greyS12B700)]
        label.attributedText = AttributedText.createString(texts: title)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapGetBackToHome() {
        viewModel.getBackToHome()
    }
}

extension NotMaintenancePeriodViewController: NotMaintenancePeriodViewModelDelegate {
    
}
