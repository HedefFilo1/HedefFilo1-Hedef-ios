//
//  AccidentSuccessRandevuViewController.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation
import UIKit

class AccidentSuccessRandevuViewController: UIViewController {

    var viewModel: AccidentSuccessRandevuViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var randveuView: UIView!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var homeButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setRandevu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.viewControllers.removeAll { (controller) -> Bool in
            return controller.isKind(of: ServiceRandevuViewController.self)
        }
        circleView.layer.cornerRadius = circleView.bounds.height/2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        homeButton.isEnabled = true
    }
    
    func applyStyle() {
        circleView.layer.cornerRadius = 40
        titleLabel.apply(.blackS18B700)
        desciptionLabel.apply(.greyS14R400)
        randveuView.layer.cornerRadius = 10
        randveuView.layer.borderColor = UIColor.borderColor.cgColor
        randveuView.layer.borderWidth = 1
    
        supplierNameLabel.apply(.blackS20B700)
        addressLabel.apply(.greyS12R400)
        phoneLabel.apply(.blackS12R400)
        dateLabel.apply(.blackS16R400)
        messageLabel.apply(.blackS14B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.success.title")
        desciptionLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.success.description")
        if viewModel.date != nil {
            desciptionLabel.text = ""
        }
        
        if viewModel.accidentReportType == .anlasmalITutanak {
            messageLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.success.minute.warning")
            
        } else if viewModel.accidentReportType == .zabit {
//            messageLabel.text = Strings.keepPoliceReport
            messageLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.zabıt.success.minute.warning")
            
        } else if viewModel.accidentReportType == .beyan {
            messageLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.beyan.success.minute.warning")
        }
        homeButton.setTitle(App.getString(key: "copilotapp.servicemaintenance.maintenance.operation.schedule.maintenance.appointment.negative.result.button"), for: .normal)
    }

    @IBAction func didTapClose() {
        viewModel.getBack()
    }
    
    @IBAction func didTapEdit() {
        viewModel.getBack()
    }
    
    @IBAction func didTapHome() {
        viewModel.getBackToHome()
    }
    
    func setRandevu() {
        var phone = ""
        if let service = viewModel.service {
            supplierNameLabel.text = service.name
            addressLabel.text = service.address
            phoneLabel.text = service.phone
            phone = service.phone ?? ""
            
        }
       
        if let date = viewModel.displayDate {
            dateLabel.text = date
        } else {
            phoneLabel.text = "\(phone)\n"
            dateLabel.removeFromSuperview()
        }
    }
}

extension AccidentSuccessRandevuViewController: AccidentSuccessRandevuViewModelDelegate {
    
}
