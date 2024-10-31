//
//  VehicleServicesSearchCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

protocol RequestListSearchCellDelegate: AnyObject {
    func didTapFilter()
    func didTapSort()
    func didChangeSearch(text: String)
    func didTapRemoveFilter()
}

class RequestListSearchCell: UICollectionViewCell, Reusable {
   
    weak var delegate: RequestListSearchCellDelegate?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var filterItemLabel: UILabel!
    @IBOutlet weak var filterItemView: UIView!
    @IBOutlet weak var searchTextField: CPSearchTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        searchTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        applyStyles()
        setTexts()
        filterItemView.isHidden = true
    }
    
    func applyStyles() {
        backgroundColor = .white
        descriptionLabel.apply(.blackS14R400)
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.borderColor.cgColor
        filterView.layer.cornerRadius = 10
        filterLabel.apply(.blackS14B700)
        
        sortView.layer.borderWidth = 1
        sortView.layer.borderColor = UIColor.borderColor.cgColor
        sortView.layer.cornerRadius = 10
        sortLabel.apply(.blackS14B700)
        
        searchTextField.setTint(color: .fieldsTitle)
        searchTextField.apply(.blackS14R400)
        filterItemLabel.apply(.blackS12B700)
        filterItemView.layer.borderWidth = 1
        filterItemView.layer.borderColor = UIColor.greyTextLight.cgColor
        filterItemView.layer.cornerRadius = 10
    }
    
    func setTexts() {
        searchTextField.placeholder = App.getString(key: "copilotapp.help.feedback.process.demand.button_search")
        filterLabel.text = App.getString(key: "copilotapp.service.service.list.productservice.filter")
        sortLabel.text = App.getString(key: "copilotapp.service.service.list.productservice.sort")
    }
    
    func setFilter(item: String?) {
        if let item {
            filterItemLabel.text = item
            filterItemView.isHidden = false
        } else {
            filterItemView.isHidden = true
        }
    }
    
    @objc func editingChanged() {
        let text = searchTextField.text ?? ""
        delegate?.didChangeSearch(text: text)
    }
    
    @IBAction func didTapFilter() {
        delegate?.didTapFilter()
    }
    
    @IBAction func didTapSort() {
        delegate?.didTapSort()
    }
    
    @IBAction func didTapRemoveFilter() {
        setFilter(item: nil)
        delegate?.didTapRemoveFilter()
    }
}
