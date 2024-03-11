//
//  NotificationSettingsViewController.swift
//  Copilot
//
//  Created by Jamal on 3/11/24.
//

import Foundation
import UIKit

class NotificationSettingsViewController: UIViewController {
    
    var viewModel: NotificationSettingsViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherSwitch: UISwitch!
    
    @IBOutlet weak var campaignsLabel: UILabel!
    @IBOutlet weak var campaignsSwitch: UISwitch!
   
    @IBOutlet weak var randevueDateLabel: UILabel!
    @IBOutlet weak var randevueDateSwitch: UISwitch!
   
    @IBOutlet weak var contractLabel: UILabel!
    @IBOutlet weak var contractSwitch: UISwitch!
    
    @IBOutlet weak var cancelButton: CPLightButton!
    @IBOutlet weak var saveButton: CPButton!
    
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
        saveButton.isEnabled = true
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.greyS14R400)
        weatherLabel.apply(.blackS14M500)
        campaignsLabel.apply(.blackS14M500)
        randevueDateLabel.apply(.blackS14M500)
        contractLabel.apply(.blackS14M500)
    }
    
    func setTexts() {
        titleLabel.text = Strings.notifications
        descriptionLabel.text = Strings.notificationSettingsDescription
        weatherLabel.text = Strings.weatherSettings
        campaignsLabel.text = Strings.campaigns
        randevueDateLabel.text = Strings.appointmentDate
        contractLabel.text = Strings.contractDuration
        cancelButton.setTitle(Strings.cancel, for: .normal)
        saveButton.setTitle(Strings.save, for: .normal)
    }
    
    @IBAction func didTapWeatherSwitch() {
        
    }
    
    @IBAction func didTapCampaignSwitch() {
    }
    
    @IBAction func didTapRandevueSwitch() {
        
    }
    
    @IBAction func didTapContractSwitch() {
        
    }
    
    @IBAction func didTapCancel() {
        viewModel.getBack()
    }
    
    @IBAction func didTapSave() {
        
    }
}

extension NotificationSettingsViewController: NotificationSettingsViewModelDelegate {
    
}
