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
    
    var showRandevu = false
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var careButton: CPLightButton!
    @IBOutlet weak var faultButton: CPLightButton!
    @IBOutlet weak var randevuLabel: UILabel!
    @IBOutlet weak var randevuView: UIView!
    @IBOutlet weak var lastikButton: CPLightButton!
    @IBOutlet weak var pastServicesButton: CPGreyButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
#if DEV_DEBUG
        //        if let coordintor = viewModel.coordinatorDelegate as? ServicesCoordinator {
        //            coordintor.goToServiceDetail(service: Supplier(id: "e3", name: "Boch SErvice", address: "Marawa", lon: "", lat: ""))
        //        }
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        randevuView.heightConstraint?.constant = showRandevu ? 27: 0
        randevuView.isHidden = !showRandevu
        view.animate()
    }
    
    func setupUI() {
        setBasicViews()
        randevuView.heightConstraint?.constant = showRandevu ? 27: 0
        randevuView.isHidden = !showRandevu
        applyStyle()
        setTexts()
        
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.blackS18B700)
        randevuView.layer.cornerRadius = 10
        randevuView.clipsToBounds = true
        randevuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        randevuLabel.apply(.whiteS12B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.service
        descriptionLabel.text = Strings.selectService
        careButton.setTitle(Strings.care, for: .normal)
        faultButton.setTitle(Strings.fault, for: .normal)
        lastikButton.setTitle(Strings.lastik, for: .normal)
        pastServicesButton.setTitle(Strings.pastServiceTransactions, for: .normal)
    }
    
    @IBAction func didTapCareButton() {
        
    }
    
    @IBAction func didTapFaultButton() {
        
    }
    
    @IBAction func didTapLastikButton() {
        var service: Supplier? = nil
        if showRandevu {
            service = Supplier(id: "232", name: "Service name", address: "Address", lon: nil, lat: nil)
        }
        viewModel.goToLastikOperations(service: service)
    }
    
    @IBAction func didTapPastServicesButton() {
        
    }
}

extension ServiceTabViewController: ServiceTabViewModelDelegate {
    
}
