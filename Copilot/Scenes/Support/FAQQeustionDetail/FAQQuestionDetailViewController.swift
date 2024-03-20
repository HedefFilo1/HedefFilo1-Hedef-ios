//
//  FAQQuestionDetailViewController.swift
//  Copilot
//
//  Created by Jamal on 3/20/24.
//

import Foundation
import UIKit

class FAQQuestionDetailViewController: UIViewController {
    
    var viewModel: FAQQuestionDetailViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
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
        textView.text = viewModel.item?.description ?? ""
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        textView.apply(.greyS14R400)
    }
    
    func setTexts() {
        titleLabel.text = viewModel.item?.title
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension FAQQuestionDetailViewController: FAQQuestionDetailViewModelDelegate {
   
}
