//
//  FeedbackFilterViewController.swift
//  Copilot
//
//  Created by Jamal on 3/24/24.
//

import Foundation
import UIKit

protocol FeedbackFilterViewControllerDelegate: AnyObject {
    func didTapApply(selectedItem: FeedbackFilterItem)
}

class FeedbackFilterViewController: SheetViewController {
    
    var viewModel: FeedbackFilterViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 210
    }
    weak var delegate: FeedbackFilterViewControllerDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterList: CPDropDownList!
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
        filterList.delegate = self
        filterList.isUpSide = true
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        view.backgroundColor = .white
        titleLabel.text = Strings.filter
        filterList.title = Strings.serviceProcess
    }
    
    func setButtonActivation() {
        let item = filterList.hasSelectedItem
        applyButton.isEnabled = item
    }
    
    @IBAction func didTapClose() {
        dismiss(animated: true)
    }
    
    @IBAction func didTapApply() {
        dismiss(animated: true) { [weak self] in
            guard let self, let item = viewModel.selectedItem else { return }
            self.delegate?.didTapApply(selectedItem: item)
        }
    }
}

extension FeedbackFilterViewController: CPDropDownListDelegate {
    
    func superViewForDropDown(in dropDownList: CPDropDownList) -> UIView? {
                return self.presentationController?.containerView ?? self.view
//        return view
    }
    
    func numberOfItems(in dropDownList: CPDropDownList) -> Int {
        return viewModel.items.count
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, titleFor index: Int) -> String {
        return viewModel.items[index].title
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, didSelect index: Int) {
        viewModel.selectedItem = viewModel.items[index]
    }
    
    func willOpen(_ dropDownList: CPDropDownList) {
    }
    
    func willDismiss(_ dropDownList: CPDropDownList) {
        
    }
    
    func didDismiss(_ dropDownList: CPDropDownList) {
        setButtonActivation()
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, shouldSelect index: Int) -> Bool {
        return false
    }
}

extension FeedbackFilterViewController: FeedbackFilterViewModelDelegate {
    
}
