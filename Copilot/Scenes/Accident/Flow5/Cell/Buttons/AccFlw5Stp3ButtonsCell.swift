//
//  AccFlw4SelectPhotoCell.swift
//  Copilot
//
//  Created by Jamal on 2/22/24.
//

import UIKit

protocol AccFlw5Stp3ButtonsCellDelegate: AnyObject {
    func didTapUpload()
    func didTapContinue()
}

class AccFlw5Stp3ButtonsCell: UICollectionViewCell, Reusable {
    
    weak var delegate: AccFlw5Stp3ButtonsCellDelegate?
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var continueButton: CPButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setTexts()
        
    }
    
    func setup() {
        uploadLabel.apply(.themeS16B700)
        uploadView.layer.cornerRadius = 10
        uploadView.layer.borderWidth = 1
        uploadView.layer.borderColor = UIColor.theme.cgColor
        continueButton.isEnabled = true
    }
    
    func setTexts() {
        uploadLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.upload.more.photo.button")
        continueButton.setTitle(Strings.devamEt, for: .normal)
    }
    
    @IBAction func didTapUpload() {
        delegate?.didTapUpload()
    }
    
    @IBAction func didTapContinue() {
        delegate?.didTapContinue()
    }
}
