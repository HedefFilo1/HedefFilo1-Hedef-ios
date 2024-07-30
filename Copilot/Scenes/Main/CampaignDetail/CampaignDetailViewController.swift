//
//  CampaignDetailViewController.swift
//  Copilot
//
//  Created by Jamal on 11/7/23.
//

import Foundation
import UIKit

class CampaignDetailViewController: UIViewController {
    
    var viewModel: CampaignDetailViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var benefitButton: CPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setCampaign()
        hideTabbarView()
    }
    
    func setupUI() {
        benefitButton.isEnabled = true
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        backImageView.image = backImageView.image?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = .lightBlack
        titleLabel.apply(.blackS18B700)
        nameLabel.apply(.blackS16B700)
        textLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
        benefitButton.setTitle(App.getString(key: "copilotapp.campaign.benefit.campaign.button"), for: .normal)
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
    
    @IBAction func didTapSelect(_ sender: UIButton) {
        viewModel.selectCampaign()
    }
}

extension CampaignDetailViewController: CampaignDetailViewModelDelegate {
    
    func setCampaign() {
        imageView.loadImageFrom(url: viewModel.campaign?.imageFile)
        titleLabel.text = viewModel.campaign?.title
        nameLabel.text = viewModel.campaign?.title
        textLabel.text = viewModel.campaign?.content
        benefitButton.isHidden = viewModel.campaign?.campaignType != .campaign
    }
    
    func showSuccessMessage() {
        let message = App.getString(key: "copilotapp.campaign.success") ?? ""
        let title = App.getString(key: "copilotapp.campaign.success.okey.button") ?? ""
        showSuccess(successTitle: "", message: message, buttonTitle: title, delegate: self)
    }
}

extension CampaignDetailViewController: MessagePopupViewControllerDelegate {
    func didDismiss(_: SuccessPopupViewController?) {
        viewModel.getBack()
    }
}
