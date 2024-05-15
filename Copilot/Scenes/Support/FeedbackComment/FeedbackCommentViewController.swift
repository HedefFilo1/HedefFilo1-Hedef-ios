//
//  FeedbackCommentViewController.swift
//  Copilot
//
//  Created by Jamal on 3/24/24.
//

import Foundation
import UIKit

class FeedbackCommentViewController: SheetViewController {
    
    var viewModel: FeedbackCommentViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 322
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var answerTextFeild: CPTextField!
    @IBOutlet weak var sendButton: CPButton!
    
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
        answerTextFeild.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
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
        descriptionLabel.text = App.getString(key: "copilotapp.help.feedback.process.demand.satisfaction_survey_question")
        
        answerTextFeild.placeholder = App.getString(key: "copilotapp.help.feedback.process.demand.satisfaction_survey_input")
        sendButton.setTitle( App.getString(key: "copilotapp.help.feedback.process.demand.button_send"), for: .normal)
    }
    
    func setButtonActivation() {
        sendButton.isEnabled = answerTextFeild.pureTextCount > 0
    }
    
    @objc func editingChanged() {
        setButtonActivation()
    }
    
    @IBAction func didTapBack() {
        viewModel.getBackFromFeedbackComment()
    }
    
    @IBAction func didTapClose() {
        dismiss(animated: true)
    }
    
    @IBAction func didTapButton() {
        let comment = answerTextFeild.text ?? ""
        viewModel.sendFeedBack(comment: comment)
    }
}

extension FeedbackCommentViewController: FeedbackCommentViewModelDelegate,
                                         MessagePopupViewControllerDelegate {
    func didDismiss(_: SuccessPopupViewController?) {
        dismiss(animated: true)
    }
    
    func didFinishSendFeedBack() {
        showSuccess(title: "", message: Strings.feedbackCreatedSuccessfully, delegate: self)
        
    }
}
