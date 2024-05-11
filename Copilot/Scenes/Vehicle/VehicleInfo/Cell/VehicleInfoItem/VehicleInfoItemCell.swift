//
//  VehicleInfoItemCell.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import UIKit

protocol VehicleInfoItemCellDelegate: AnyObject {
    func didTapDownload(document: Document)
}

class VehicleInfoItemCell: UICollectionViewCell, Reusable {
    
    var item: Document?
    weak var delegate: VehicleInfoItemCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS14B700)
        downloadLabel.apply(.themeS12B700)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
    }
    
    func setTexts() {
        downloadLabel.text = App.getString(key: "copilotapp.vehicleinfo.download.button")
    }
    
    @IBAction func didTapDownload() {
        if let item = item {
            delegate?.didTapDownload(document: item)
        }
    }
}
