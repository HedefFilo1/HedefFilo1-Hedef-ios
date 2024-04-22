//
//  LanguagesViewController.swift
//  Copilot
//
//  Created by Jamal on 3/12/24.
//

import Foundation
import UIKit

class LanguagesViewController: SheetViewController {
    
    override var presentationHeight: CGFloat {
        return 256
    }
    
    var viewModel: LanguagesViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var turkeyLabel: UILabel!
    @IBOutlet weak var turkeyRadio: CPRadioBox!
    
    @IBOutlet weak var englishRadio: CPRadioBox!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var applyButton: CPButton!

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
        applyButton.isEnabled = true
        let language = Persistence.language ?? CodeStrings.turkish
        turkeyRadio.isSelected = language == CodeStrings.turkish
        englishRadio.isSelected = language == CodeStrings.english
    }
    
    func applyStyle() {
        turkeyRadio.layer.cornerRadius = 12
        englishRadio.layer.cornerRadius = 12
        titleLabel.apply(.blackS18B700)
        turkeyLabel.apply(.blackS12R400)
        englishLabel.apply(.blackS12R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.languageWord
        turkeyLabel.text = Strings.turkish
        englishLabel.text = Strings.english
        applyButton.setTitle(Strings.apply, for: .normal)
    }
    
    @IBAction func didTapDismiss() {
        dismiss(animated: true)
    }
    
    @IBAction func didTapTurkish() {
        turkeyRadio.isSelected = true
        englishRadio.isSelected = false
    }
    
    @IBAction func didTapEnglish() {
        turkeyRadio.isSelected = false
        englishRadio.isSelected = true
    }
    
    @IBAction func didTapApply() {
        let language = turkeyRadio.isSelected ? CodeStrings.turkish: CodeStrings.english
        App.changeLanguage(language: language)
        if turkeyRadio.isSelected {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTING_LANGUAGE_SELECTION_TR")
        } else {
            APIService.addUserAction(pageName: "Settings", actionName: "SETTING_LANGUAGE_SELECTION_ENG")
        }
    }
    
}

extension LanguagesViewController: LanguagesViewModelDelegate {
    
}
