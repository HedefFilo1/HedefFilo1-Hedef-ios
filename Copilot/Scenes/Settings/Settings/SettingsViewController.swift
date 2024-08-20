//
//  SettingsViewController.swift
//  Copilot
//
//  Created by Jamal on 3/11/24.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var viewModel: SettingsViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notifiationsLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var agreementLabel: UILabel!
    
    @IBOutlet weak var langaugesView: UIView!
    @IBOutlet weak var langaugeLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
        //        pointsView.imageView.image = Images.lastikPoints
        let language = App.language
        langaugeLabel.text = language == CodeStrings.turkish ? Strings.turkish : Strings.english
        flagImageView.image = language == CodeStrings.turkish ? Images.circleTurkeyFlag: Images.circleEnglishFlag
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        notifiationsLabel.apply(.blackS14M500)
        darkModeLabel.apply(.blackS14M500)
        agreementLabel.apply(.blackS14M500)
        
        langaugesView.layer.cornerRadius = 4
        langaugesView.layer.borderWidth = 1
        langaugesView.layer.borderColor = UIColor.textGrey.cgColor
        langaugeLabel.apply(.blackS12R400)
        darkModeSwitch.onTintColor = .theme
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "settings.settings")
        notifiationsLabel.text = App.getString(key: "copilotapp.notification.title")
        darkModeLabel.text = App.getString(key: "setting.nightmode")
        agreementLabel.text = App.getString(key: "settings.see.privacy.policy")
    }
    
    @IBAction func didTapNotification() {
        viewModel.goToNotificationSettings()
    }
    
    @IBAction func didTapDarkMode() {
        
//        UIWindowScene.windows.forEach { window in
//            window.overrideUserInterfaceStyle = darkModeSwitch.isOn ? .dark: .light
//        }
        
//        App.window.overrideUserInterfaceStyle = darkModeSwitch.isOn ? .dark: .light
//        overrideUserInterfaceStyle = darkModeSwitch.isOn ? .dark: .light
    }
    
    @IBAction func didTapAgreemnt() {
        viewModel.goToAgreement()
    }
    
    @IBAction func didTapLanguages() {
        viewModel.presentLangauges()
    }
}

extension SettingsViewController: SettingsViewModelDelegate {
    
}
