//
//  ServicesSearchCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

protocol PastServicesSearchCellDelegate: AnyObject {
    func didTapSort()
    func didTapFilter()
    func didChangeSearch(text: String)
}

class PastServicesSearchCell: UICollectionViewCell, Reusable {
    
    weak var delegate: PastServicesSearchCellDelegate?
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var searchTextField: CPSearchTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        searchTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        applyStyles()
        setTexts()
    }
    
    func applyStyles() {
        backgroundColor = .white
        
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
    }
    
    func setTexts() {
        searchTextField.placeholder = App.getString(key: "copilotapp.pastservice.past.maintenance.operation.service.search.button")
        filterLabel.text = App.getString(key: "copilotapp.pastservice.operation.filter.button")
        sortLabel.text = App.getString(key: "copilotapp.pastservice.operation.sort.button")
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
}
