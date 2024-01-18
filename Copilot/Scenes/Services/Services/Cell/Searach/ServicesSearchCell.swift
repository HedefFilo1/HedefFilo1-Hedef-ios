//
//  ServicesSearchCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

protocol ServicesSearchCellDelegate: AnyObject {
    func didTapFilter()
    func didTapRemoveFilter()
    func didChangeSearch(text: String)
}

class ServicesSearchCell: UICollectionViewCell, Reusable {
    
    weak var delegate: ServicesSearchCellDelegate?
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
        removFilterLabel.apply(.blackS12B700)
        filterCityLabel.apply(.blackS12B700)
    }
    
    @objc func editingChanged() {
        let text = searchTextField.text ?? ""
        delegate?.didChangeSearch(text: text)
    }
    
    func setFilters(city: String?, district: String?) {
        if city == nil && district == nil {
            removFilterView.isHidden = true
        } else {
            removFilterView.isHidden = false
        }
        
        filterCityLabel.text = city
        filterCityView.isHidden = city == nil
        
        if city == nil, district != nil {
            filterCityLabel.text = district
            filterCityView.isHidden = false
        }
        
//        filterDistrictView.isHidden = district == nil
        filterDistrictView.isHidden = true
        
    }
    
    @IBAction func didTapFilter() {
        delegate?.didTapFilter()
    }
    
    @IBAction func didTapRemoveFilter() {
        filterCityView.isHidden = true
        removFilterView.isHidden = true
        delegate?.didTapRemoveFilter()
    }
}
