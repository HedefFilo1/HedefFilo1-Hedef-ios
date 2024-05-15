//
//  HGSDetailViewController.swift
//  Copilot
//
//  Created by Jamal on 11/28/23.
//

import Foundation
import UIKit

class HGSDetailViewController: UIViewController {
    
    var viewModel: HGSDetailViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var fieldLabels: [UILabel]!
    @IBOutlet var valueLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTransition()
        APIService.addUserAction(pageName: "Car Informations", actionName: "VEHICLE_HGS_TRANSITION_DETAILED_INFO")
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        backImageView.image = backImageView.image?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = .lightBlack
        titleLabel.apply(.blackS18B700)
        for label in fieldLabels {
            label.apply(.greyS14R400)
        }
        
        for label in valueLabels {
            label.apply(.blackS14B700)
        }
    }
    
    func setTexts() {
        fieldLabels[0].text = App.getString(key: "copilotapp.hgstransition.enter")
        fieldLabels[1].text = App.getString(key: "copilotapp.hgstransition.exit")
        fieldLabels[2].text = App.getString(key: "copilotapp.hgstransition.detail.transaction.date")
        fieldLabels[3].text = App.getString(key: "copilotapp.hgstransition.detail.transaction.time")
        fieldLabels[4].text = App.getString(key: "copilotapp.hgstransition.detail.transaction.id")
        fieldLabels[5].text = App.getString(key: "copilotapp.hgstransition.detail.entry.date")
        fieldLabels[6].text = App.getString(key: "copilotapp.hgstransition.detail.entry.time")
        fieldLabels[7].text = App.getString(key: "copilotapp.hgstransition.detail.release.date")
        fieldLabels[8].text = App.getString(key: "copilotapp.hgstransition.detail.release.time")
        fieldLabels[9].text = App.getString(key: "copilotapp.hgstransition.detail.amount")
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
    
    @IBAction func didTapDowndload(_ sender: UIButton) {

    }
    
    func setTransition() {
        if let item = viewModel.transition {
            valueLabels[0].text = item.entryPoint
            valueLabels[1].text = item.exitPoint
            valueLabels[2].text = item.exitJustDisplayDate
            valueLabels[3].text = item.exitHourDisplayDate
            
            valueLabels[5].text = item.entryJustDisplayDate
            valueLabels[6].text = item.entryHourDisplayDate
            valueLabels[7].text = item.exitJustDisplayDate
            valueLabels[8].text = item.exitHourDisplayDate
            valueLabels[9].text = item.displayToll
        }
    }
}

extension HGSDetailViewController: HGSDetailViewModelDelegate {
    
}
