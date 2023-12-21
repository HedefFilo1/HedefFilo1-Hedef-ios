//
//  LastikOperationsViewController.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation
import UIKit

class LastikOperationsViewController: UIViewController {
    
    var viewModel: LastikOperationsViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var requestNewButton: CPLightButton!
    @IBOutlet weak var randevuButton: CPLightButton!
    @IBOutlet weak var changeButton: CPLightButton!
    
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
    }
    
    func setTexts() {
        titleLabel.text = Strings.tireOperations
        requestNewButton.setTitle(Strings.requestNewTire, for: .normal)
        randevuButton.setTitle(Strings.tireDamageAppointment, for: .normal)
        changeButton.setTitle(Strings.tireChangeAppointment, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapRequestNew() {
        
    }
    
    @IBAction func didTapRandevu() {
        
    }
    
    @IBAction func didTapChange() {
        
    }
}

extension LastikOperationsViewController: LastikOperationsViewModelDelegate {
    
}
