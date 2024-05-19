//
//  PastServicesFilterViewController.swift
//  Copilot
//
//  Created by Jamal on 4/1/24.
//

import Foundation
import UIKit

protocol PastServicesFilterViewControllerDelegate: AnyObject {
    func didTapApply(city: String?, district: String?, date: Date?)
}

class PastServicesFilterViewController: SheetViewController {
    
    var viewModel: PastServicesFilterViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 358
    }
    weak var delegate: PastServicesFilterViewControllerDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var citiesList: CPDropDownList!
    @IBOutlet weak var districtList: CPDropDownList!
    @IBOutlet weak var dateChooseView: CPDateChooseView!
    @IBOutlet weak var applyButton: CPButton!
    
    var openedList: CPDropDownList?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        citiesList.delegate = self
        districtList.delegate = self
        //        citiesList.isUpSide = true
        dateChooseView.delegate = self
        dateChooseView.dateFormat = "dd.MM.yyyy"
        districtList.isUpSide = true
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        view.backgroundColor = .white
        titleLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.filter.title")
        citiesList.title = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.filter.province") ?? ""
        districtList.title = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.filter.district") ?? ""
        citiesList.valueLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.filter.select")
        districtList.valueLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.filter.select")
        dateChooseView.title = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.filter.select.date") ?? ""
    }
    
    func setButtonActivation() {
        let province = citiesList.hasSelectedItem
        let district = districtList.hasSelectedItem
        let date = dateChooseView.date != nil
        applyButton.isEnabled = province || district || date
    }
    
    @IBAction func didTapClose() {
        dismiss(animated: true)
    }
    
    @IBAction func didTapApply() {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            self.delegate?.didTapApply(
                city: self.viewModel.selectedCity?.name,
                district: self.viewModel.selectedDistrict,
                date: dateChooseView.date)
        }
    }
}

extension PastServicesFilterViewController: CPDateChooseViewDelegate,
                                            CalendarViewControllerDelegate {
    
    func didSelect(_: CalendarViewController, date: Date) {
        dateChooseView.date = date
        setButtonActivation()
    }
    
    func didTap(_: CPDateChooseView) {
        viewModel.presentCalendar(delegate: self)
    }
}

extension PastServicesFilterViewController: CPDropDownListDelegate {
    
    func superViewForDropDown(in dropDownList: CPDropDownList) -> UIView? {
        //        return self.presentationController?.containerView ?? self.view
        return view
    }
    
    func numberOfItems(in dropDownList: CPDropDownList) -> Int {
        if dropDownList == citiesList {
            return viewModel.cities.count
        }
        return viewModel.selectedCity?.districts.count ?? 0
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, titleFor index: Int) -> String {
        
        if dropDownList == citiesList {
            return viewModel.cities[index].name
        }
        return viewModel.selectedCity?.districts[index] ?? ""
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, didSelect index: Int) {
        if dropDownList == citiesList {
            viewModel.selectedCity = viewModel.cities[index]
            districtList.clearSelection()
        } else {
            viewModel.selectedDistrict = viewModel.selectedCity?.districts[index]
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

extension PastServicesFilterViewController: PastServicesFilterViewModelDelegate {
    
}
