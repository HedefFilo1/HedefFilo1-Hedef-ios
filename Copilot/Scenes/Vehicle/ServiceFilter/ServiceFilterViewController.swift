//
//  ServiceFilterViewController.swift
//  Copilot
//
//  Created by Jamal on 12/29/23.
//

import Foundation
import UIKit

class ServiceFilterViewController: SheetViewController {
    
    var viewModel: ServiceFilterViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }

    override var presentationHeight: CGFloat {
        return 290
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var provinceList: CPDropDownList!
    @IBOutlet weak var districtList: CPDropDownList!
    @IBOutlet weak var applyButton: CPButton!
    
    var openedList: CPDropDownList?
    
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
        provinceList.delegate = self
        districtList.delegate = self
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        view.backgroundColor = .white
        titleLabel.text = Strings.filter
        provinceList.title = Strings.province
        districtList.title = Strings.district
        provinceList.valueLabel.text = Strings.choose
        districtList.valueLabel.text = Strings.choose
    }
    
    func setButtonActivation() {
        let province = provinceList.hasSelectedItem
        let district = districtList.hasSelectedItem
        applyButton.isEnabled = province && district
    }
    
    @IBAction func didTapClose() {
        dismiss(animated: true)
    }
    
    @IBAction func didTapApply() {
        dismiss(animated: true)
    }
}

extension ServiceFilterViewController: CPDropDownListDelegate {
    
    func superViewForDropDown(in dropDownList: CPDropDownList) -> UIView? {
        return view
    }
    
    func numberOfItems(in dropDownList: CPDropDownList) -> Int {
        2
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, titleFor index: Int) -> String {
        
        if dropDownList == provinceList {
            return viewModel.provinces?[index] ?? ""
        }
        return Strings.district
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, didSelect index: Int) {
        
    }
    
    func willOpen(_ dropDownList: CPDropDownList) {
        if openedList == dropDownList {
            return
        }
        openedList?.dismiss()
        openedList = dropDownList
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

extension ServiceFilterViewController: ServiceFilterViewModelDelegate {
   
}


