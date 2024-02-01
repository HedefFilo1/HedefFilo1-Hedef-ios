//
//  ServiceTabViewController.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation
import UIKit

class ServiceTabViewController: UIViewController {
    
    var viewModel: ServiceTabViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var careButton: CPLightButton!
    @IBOutlet weak var faultButton: CPLightButton!
    @IBOutlet weak var maintenanceRandevuLabel: UILabel!
    @IBOutlet weak var maintenanceRandevuView: UIView!
    
    @IBOutlet weak var tireRandevuLabel: UILabel!
    @IBOutlet weak var tireRandevuView: UIView!
    @IBOutlet weak var lastikButton: CPLightButton!
    @IBOutlet weak var pastServicesButton: CPGreyButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
#if DEV_DEBUG
//        let str = Date().getServerDate()
//        print(str)
//                if let coordintor = viewModel.coordinatorDelegate as? ServicesCoordinator {
//                    coordintor.goToLastikOperations(appointment: nil)
//                }
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeTireAppointment()
        removeMaintenanceAppointment()
        viewModel.getAppointments()
    }
    
    func setupUI() {
        setBasicViews()
        tireRandevuView.heightConstraint?.constant = 0
        tireRandevuView.isHidden = true
        
        maintenanceRandevuView.heightConstraint?.constant = 0
        maintenanceRandevuView.isHidden = false
        
        applyStyle()
        setTexts()
        
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.blackS18B700)
        maintenanceRandevuView.layer.cornerRadius = 10
        maintenanceRandevuView.clipsToBounds = true
        maintenanceRandevuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        maintenanceRandevuLabel.apply(.whiteS12B700)
        
        tireRandevuView.layer.cornerRadius = 10
        tireRandevuView.clipsToBounds = true
        tireRandevuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tireRandevuLabel.apply(.whiteS12B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.service
        descriptionLabel.text = Strings.selectService
        careButton.setTitle(Strings.care, for: .normal)
        faultButton.setTitle(Strings.fault, for: .normal)
        lastikButton.setTitle(Strings.lastik, for: .normal)
        tireRandevuLabel.text = Strings.appointmentRequestReceived
        maintenanceRandevuLabel.text = Strings.appointmentRequestReceived
        pastServicesButton.setTitle(Strings.pastServiceTransactions, for: .normal)
    }
    
    @IBAction func didTapCareButton() {
        viewModel.goToMaintenance()
    }
    
    @IBAction func didTapFaultButton() {
        viewModel.goToBreakDown()
    }
    
    @IBAction func didTapLastikButton() {
        viewModel.goToLastikOperations()
    }
    
    @IBAction func didTapPastServicesButton() {
        
    }
}

extension ServiceTabViewController: ServiceTabViewModelDelegate {
    
    func setTireAppointment() {
        tireRandevuView.heightConstraint?.constant = 27
        tireRandevuView.isHidden = false
        let type = viewModel.tireAppointment?.appointmentStatus ?? .none
        if type == .appointmentApproved {
            tireRandevuView.backgroundColor = .textSuccess
            tireRandevuLabel.text = Strings.randevuApproved
        }
        view.animate()
    }
    
    func removeTireAppointment() {
        tireRandevuView.heightConstraint?.constant = 0
        tireRandevuView.isHidden = true
        view.animate()
    }
    
    func setMaintenanceAppointment() {
        maintenanceRandevuView.heightConstraint?.constant = 27
        maintenanceRandevuView.isHidden = false
        let type = viewModel.maintenanceAppointment?.appointmentStatus ?? .none
        if type == .appointmentApproved {
            maintenanceRandevuView.backgroundColor = .textSuccess
            maintenanceRandevuLabel.text = Strings.randevuApproved
        }
        view.animate()
    }
    
    func removeMaintenanceAppointment() {
        maintenanceRandevuView.heightConstraint?.constant = 0
        maintenanceRandevuView.isHidden = true
        view.animate()
    }
}
