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
        viewModel.getPrefrences()
        
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
        viewModel.setNotificationPreferences(type: .weather, enabled: weatherSwitch.isOn)
        if weatherSwitch.isOn {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTINGS_NOTIFICATION_WEATHER_ACTIVE_SWITCH")
        } else {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTINGS_NOTIFICATION_WEATHER_PASSIVE_SWITCH")
        }
    }
    
    @IBAction func didTapCampaignSwitch() {
        viewModel.setNotificationPreferences(type: .campaign, enabled: campaignsSwitch.isOn)
        if weatherSwitch.isOn {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTINGS_NOTIFICATION_CAMPAIGN_ACTIVE_SWITCH")
        } else {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTINGS_NOTIFICATION_CAMPAIGN_PASSIVE_SWITCH")
        }
    }
    
    @IBAction func didTapRandevueSwitch() {
        viewModel.setNotificationPreferences(type: .appointmentDate, enabled: randevueDateSwitch.isOn)
        
        if weatherSwitch.isOn {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTINGS_NOTIFICATION_APPOINTMEN_DATE_ACTIVE_SWITCH")
        } else {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTINGS_NOTIFICATION_APPOINTMEN_DATE_PASSIVE_SWITCH")
        }
    }
    
    @IBAction func didTapContractSwitch() {
        viewModel.setNotificationPreferences(type: .agreement, enabled: contractSwitch.isOn)
        if weatherSwitch.isOn {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTINGS_NOTIFICATION_CONTRACT_TERM_ACTIVE_SWITCH")
        } else {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTINGS_NOTIFICATION_CONTRACT_TERM_PASSIVE_SWITCH")
        }
    }
    
    @IBAction func didTapCancel() {
        viewModel.getBack()
    }
    
    @IBAction func didTapSave() {
        viewModel.getBack()
    }
}

extension NotificationSettingsViewController: NotificationSettingsViewModelDelegate {
    func setPrefernces() {
        weatherSwitch.isOn = viewModel.weatherEnabled
        campaignsSwitch.isOn = viewModel.campaignEnabled
        randevueDateSwitch.isOn = viewModel.appointmentEnabled
        contractSwitch.isOn = viewModel.agreementEnabled
    }
}
