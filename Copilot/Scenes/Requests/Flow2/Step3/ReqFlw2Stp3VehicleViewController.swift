//
//  ReqFlw2Stp3VehicleViewController.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation
import UIKit

class ReqFlw2Stp3VehicleViewController: UIViewController {
    
    var viewModel: ReqFlw2Stp3VehicleViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTextField: UITextView!
    
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
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18R400)
        noteLabel.apply(.blackS14R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.completedVehicleOperations
        
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension ReqFlw2Stp3VehicleViewController: ReqFlw2Stp3VehicleViewModelDelegate {
    
}
