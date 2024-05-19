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
        titleLabel.text = App.getString(key: "copilotapp.servicetire.tire.operation.title")
        descriptionLabel.text = App.getString(key: "copilotapp.servicetire.tire.operation.winter.tire.description")
        summerButton.setTitle(App.getString(key: "copilotapp.servicetire.tire.operation.winter.tire.send.request.new.summer.tire.button"), for: .normal)
        winterButton.setTitle(App.getString(key: "copilotapp.servicetire.tire.operation.winter.tire.send.request.new.winter.tire.button"), for: .normal)
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
