//
//  ServicesSearchCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

protocol ServiceOperationsSearchCellDelegate: AnyObject {
    func didTapFilter()
    func didChangeSearch(text: String)
}

class ServiceOperationsSearchCell: UICollectionViewCell, Reusable {
    
    weak var delegate: ServiceOperationsSearchCellDelegate?
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var searchTextField: CPSearchTextField!
    
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
    }
    
    func setTexts() {
        searchTextField.placeholder = App.getString(key: "copilotapp.help.feedback.process.demand.button_search")
        filterLabel.text = App.getString(key: "copilotapp.help.feedback.service.operation.button_filter")
    }
    
    @objc func editingChanged() {
        let text = searchTextField.text ?? ""
        delegate?.didChangeSearch(text: text)
    }
    
    @IBAction func didTapFilter() {
        delegate?.didTapFilter()
    }
}
