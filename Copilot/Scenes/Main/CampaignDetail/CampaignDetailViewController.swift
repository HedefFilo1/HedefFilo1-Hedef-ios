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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var benefitButton: CPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        benefitButton.setTitle(Strings.takeAdvantageCampaign, for: .normal)
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
}

extension CampaignDetailViewController: CampaignDetailViewModelDelegate {
    
}
