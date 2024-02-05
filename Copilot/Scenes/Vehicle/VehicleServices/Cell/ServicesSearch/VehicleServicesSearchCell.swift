//
//  VehicleServicesSearchCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

protocol VehicleServicesSearchCellDelegate: AnyObject {
    func didTapFilter()
    func didTapRemoveFilter()
    func didTapRemoveCityFilter()
    func didTapRemoveDistrictFilter()
    func didChangeSearch(text: String)
}

class VehicleServicesSearchCell: UICollectionViewCell, Reusable {
    
    weak var delegate: VehicleServicesSearchCellDelegate?
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterCityView: UIView!
    @IBOutlet weak var filterCityLabel: UILabel!
    @IBOutlet weak var filterDistrictView: UIView!
    @IBOutlet weak var filterDistrictLabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var searchTextField: CPSearchTextField!
    @IBOutlet weak var removFilterView: UIView!
    @IBOutlet weak var removFilterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        searchTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        applyStyles()
    }
    
    func applyStyles() {
        backgroundColor = .white
        
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.borderColor.cgColor
        filterView.layer.cornerRadius = 10
        filterLabel.apply(.blackS14B700)
        searchTextField.setTint(color: .fieldsTitle)
        searchTextField.apply(.blackS14R400)
        filterCityView.layer.borderWidth = 1
        filterCityView.layer.borderColor = UIColor.greyTextLight.cgColor
        filterCityView.layer.cornerRadius = 10
       
        filterDistrictView.layer.borderWidth = 1
        filterDistrictView.layer.borderColor = UIColor.greyTextLight.cgColor
        filterDistrictView.layer.cornerRadius = 10
        
        removFilterLabel.apply(.blackS12B700)
        filterCityLabel.apply(.blackS12B700)
        filterDistrictLabel.apply(.blackS12B700)
    }
    
    @objc func editingChanged() {
        let text = searchTextField.text ?? ""
        delegate?.didChangeSearch(text: text)
    }
    
    func setFilters(city: String?, district: String?) {
            
        removFilterView.isHidden = (city == nil && district == nil)
       
        if city != nil {
            filterCityLabel.text = city
            filterCityView.isHidden = city == nil
        } else {
            filterCityView.isHidden = true
        }
        
        if city != nil && district != nil {
            filterDistrictLabel.text = district
            filterDistrictView.isHidden = false
        } else {
            filterDistrictView.isHidden = district == nil
        }
        
    }
    
    @IBAction func didTapFilter() {
        delegate?.didTapFilter()
    }
    
    @IBAction func didTapRemoveFilter() {
        filterCityView.isHidden = true
        filterDistrictView.isHidden = true
        removFilterView.isHidden = true
        delegate?.didTapRemoveFilter()
    }
    
    @IBAction func didTapRemoveCity() {
        filterCityLabel.text = ""
        filterCityView.isHidden = true
        delegate?.didTapRemoveCityFilter()
    }
    
    @IBAction func didTapRemoveDistrict() {
        
        filterCityView.isHidden = true
        delegate?.didTapRemoveDistrictFilter()
    }
}
