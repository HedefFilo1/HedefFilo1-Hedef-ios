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
        titleLabel.text = App.getString(key: "copilotapp.servicemaintenance.maintenance.operation.schedule.maintenance.appointment.negative.result.title")
        periodLabel.text = App.getString(key: "copilotapp.servicemaintenance.maintenance.operation.schedule.maintenance.appointment.negative.result.description")
        kmLabel.text = App.getString(key: "copilotapp.servicemaintenance.maintenance.operation.suggestion")
        setPeriodLabels()
        getBackButton.setTitle(App.getString(key: "copilotapp.servicemaintenance.maintenance.operation.schedule.maintenance.appointment.negative.result.button"), for: .normal)
    }
    
    func setPeriodLabels() {
        let text = App.getString(key: "copilotapp.servicemaintenance.maintenance.operation.schedule.maintenance.appointment.negative.result.time.left.maintenance") ?? ""
        setAttributedText(label: daysLabel, title: text, value: "365 Gün")
        let str = "\(viewModel.nextMaintenanceKm)".getFormattedIntNumber()
        let text2 = App.getString(key: "copilotapp.servicemaintenance.maintenance.operation.schedule.maintenance.appointment.negative.result.km.to.maintenance") ?? ""
        setAttributedText(label: kmLabel, title: text2, value: "\(str) KM")
        let remaining = "\(viewModel.remainingKM)".getFormattedIntNumber()
        let text3 = App.getString(key: "copilotapp.servicemaintenance.maintenance.operation.schedule.maintenance.appointment.negative.result.left.maintenance") ?? ""
        setAttributedText(label: remainedKmLabel, title: text3, value: "\(remaining) KM")
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
