//
//  RequestListFilterViewController.swift
//  Copilot
//
//  Created by Jamal on 3/24/24.
//

import Foundation
import UIKit

protocol RequestListFilterViewControllerDelegate: AnyObject {
    func didTapApply(selectedItem: RequestListFilterItem)
}

class RequestListFilterViewController: SheetViewController {
    
    var viewModel: RequestListFilterViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 210
    }
    
    weak var delegate: RequestListFilterViewControllerDelegate?
    
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
        titleLabel.text = App.getString(key: "copilotapp.help.feedback.process.demand_filter")
        filterList.title = viewModel.title
        applyButton.setTitle(App.getString(key: "settings.language.apply"), for: .normal) 
    }
    
    func setButtonActivation() {
        let item = filterList.hasSelectedItem
        applyButton.isEnabled = item
    }
    
    @IBAction func didTapClose() {
        dismiss(animated: true)
    }
    
    @IBAction func didTapApply() {
        let item = viewModel.selectedItem
        dismiss(animated: true) { [weak self] in
            guard let self, let item = item  else { return }
            self.delegate?.didTapApply(selectedItem: item)
        }
    }
}

extension RequestListFilterViewController: CPDropDownListDelegate {
    
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

extension RequestListFilterViewController: RequestListFilterViewModelDelegate {
    
}
