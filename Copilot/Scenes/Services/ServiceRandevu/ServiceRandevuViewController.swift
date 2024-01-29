//
//  ServiceRandevuViewController.swift
//  Copilot
//
//  Created by Jamal on 1/3/24.
//

import Foundation
import UIKit

class ServiceRandevuViewController: UIViewController {
    
    var viewModel: ServiceRandevuViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var randveuView: UIView!
    @IBOutlet weak var confirmationLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var editButton: CPLightButton!
    @IBOutlet weak var confirmButton: CPButton!
    
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
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        editButton.isEnabled = true
        confirmButton.isEnabled = true
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        desciptionLabel.apply(.greyS14R400)
        randveuView.layer.cornerRadius = 10
        randveuView.layer.borderColor = UIColor.borderColor.cgColor
        randveuView.layer.borderWidth = 1
        
        confirmationLabel.apply(.blackS14B700)
        supplierNameLabel.apply(.blackS20B700)
        addressLabel.apply(.greyS12R400)
        phoneLabel.apply(.blackS12R400)
        dateLabel.apply(.blackS16R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.randevuConfirmation
        desciptionLabel.text = Strings.pleaseConfirmRandevu
        confirmationLabel.text = Strings.randevuRequestConfirmation
        
        editButton.setTitle(Strings.editRandevu, for: .normal)
        confirmButton.setTitle(Strings.confirmRandevu, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapEdit() {
        viewModel.getBack()
    }
    
    @IBAction func didTapConfirm() {
        viewModel.createRandevu()
    }
    
    func setRandevu() {
        if let service = viewModel.service {
            supplierNameLabel.text = service.name
            addressLabel.text = service.address
            phoneLabel.text =service.phone
        }
        dateLabel.text = viewModel.displayDate
    }
}

extension ServiceRandevuViewController: ServiceRandevuViewModelDelegate {
    
}
