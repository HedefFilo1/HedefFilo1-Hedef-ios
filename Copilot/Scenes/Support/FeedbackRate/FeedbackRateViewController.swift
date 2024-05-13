//
//  FeedbackRateViewController.swift
//  Copilot
//
//  Created by Jamal on 3/24/24.
//

import Foundation
import UIKit

class FeedbackRateViewController: SheetViewController {
    
    var viewModel: FeedbackRateViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 322
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var starButtons: [UIButton]!
    @IBOutlet weak var evaluateButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        descriptionLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
        view.backgroundColor = .white
        titleLabel.text = Strings.pastServiceSatisfactionSurvey
        descriptionLabel.text = Strings.pastServiceSatisfactionSurveyDescription
    }
    
    func setButtonActivation() {
        evaluateButton.isEnabled = viewModel.rate > 0
    }
    
    @IBAction func didTapClose() {
        dismiss(animated: true)
    }
    
    @IBAction func didTapStars(sender: UIButton) {
        let tag = sender.tag
        for (index, item) in starButtons.enumerated() {
            item.setImage(index < tag ? Images.starFilled: Images.star, for: .normal)
            item.tintColor = index < tag ? .theme: .greyTextLight
        }
        viewModel.rate = tag
        setButtonActivation()
    }
    
    @IBAction func didTapButton() {
        self.dismiss(animated: true)
        viewModel.goToFeedbackComment()
    }
}

extension FeedbackRateViewController: FeedbackRateViewModelDelegate {
    
}
