//
//  ServiceFilterViewController.swift
//  Copilot
//
//  Created by Jamal on 12/29/23.
//

import Foundation
import UIKit

protocol ServiceFilterViewControllerDelegate: AnyObject {
    func didTapApply(city: String?, district: String?)
}

class ServiceFilterViewController: SheetViewController {
    
    var viewModel: ServiceFilterViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }

    override var presentationHeight: CGFloat {
        return 290
    }
    weak var delegate: ServiceFilterViewControllerDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var citiesList: CPDropDownList!
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
        citiesList.delegate = self
        districtList.delegate = self
        citiesList.isUpSide = true
        districtList.isUpSide = true
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        view.backgroundColor = .white
        titleLabel.text = Strings.filter
        citiesList.title = Strings.province
        districtList.title = Strings.district
        citiesList.valueLabel.text = Strings.choose
        districtList.valueLabel.text = Strings.choose
    }
    
    func setButtonActivation() {
        let province = citiesList.hasSelectedItem
        let district = districtList.hasSelectedItem
        applyButton.isEnabled = province || district
    }
    
    @IBAction func didTapClose() {
        dismiss(animated: true)
    }
    
    @IBAction func didTapApply() {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            self.delegate?.didTapApply(city: self.viewModel.selectedCity, district: self.viewModel.selectedDistrict)
        }
    }
}

extension ServiceFilterViewController: CPDropDownListDelegate {
    
    func superViewForDropDown(in dropDownList: CPDropDownList) -> UIView? {
        return self.presentationController?.containerView ?? self.view
    }
    
    func numberOfItems(in dropDownList: CPDropDownList) -> Int {
        if dropDownList == citiesList {
            return viewModel.cities?.count ?? 0
        }
        return viewModel.districts?.count ?? 0
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, titleFor index: Int) -> String {
        
        if dropDownList == citiesList {
            return viewModel.cities?[index] ?? ""
        }
        return viewModel.districts?[index] ?? ""
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, didSelect index: Int) {
        if dropDownList == citiesList {
            viewModel.selectedCity = viewModel.cities?[index]
        } else {
            viewModel.selectedDistrict = viewModel.districts?[index]
        }
        
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
