//
//  VehicleInfoItemCell.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import UIKit

class VehicleInfoItemCell: UICollectionViewCell, Reusable {
    
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
        downloadLabel.text = Strings.download
    }
    
    @IBAction func didTapDownload() {
        
    }
}
