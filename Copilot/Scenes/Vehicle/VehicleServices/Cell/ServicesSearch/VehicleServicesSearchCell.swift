//
//  VehicleServicesSearchCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

protocol VehicleServicesSearchCellDelegate: AnyObject {
    func didChangeSearch(text: String)
}

class VehicleServicesSearchCell: UICollectionViewCell, Reusable {

    weak var delegate: VehicleServicesSearchCellDelegate?
//    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var filterLabel: UILabel!
//    @IBOutlet weak var sortView: UIView!
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
//        sortView.layer.borderWidth = 1
//        sortView.layer.borderColor = UIColor.borderColor.cgColor
//        sortView.layer.cornerRadius = 10
        
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.borderColor.cgColor
        filterView.layer.cornerRadius = 10
//        sortLabel.apply(.blackS14B700)
        filterLabel.apply(.blackS14B700)
        searchTextField.setTint(color: .fieldsTitle)
        searchTextField.apply(.blackS14R400)
    }
    
    @objc func editingChanged() {
        let text = searchTextField.text ?? ""
        delegate?.didChangeSearch(text: text)
    }
}
