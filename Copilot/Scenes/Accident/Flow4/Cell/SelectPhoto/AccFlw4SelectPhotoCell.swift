//
//  AccFlw4SelectPhotoCell.swift
//  Copilot
//
//  Created by Jamal on 2/22/24.
//

import UIKit

protocol AccFlw4SelectPhotoCellDelegate: AnyObject {
    func didTapUpload()
    func didTapContinue()
}

class AccFlw4SelectPhotoCell: UICollectionViewCell, Reusable {
    
    weak var delegate: AccFlw4SelectPhotoCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var continueButton: CPButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setTexts()
        
    }
    
    func setup() {
        titleLabel.apply(.blackS14B700)
        uploadLabel.apply(.themeS16B700)
        uploadView.layer.cornerRadius = 10
        uploadView.layer.borderWidth = 1
        uploadView.layer.borderColor = UIColor.theme.cgColor
        continueButton.isEnabled = true
    }
    
    func setTexts() {
        let title = App.getString(key: "copilotapp.accidentdamage.accident.process.zabit.upload.photo.description") ?? ""
        titleLabel.text = "\(CodeStrings.bullet) \(title)"
        uploadLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.upload.more.photo.button") ?? ""
        continueButton.setTitle(App.getString(key:"copilotapp.accidentdamage.accident.process.proceed.service.continue.button"), for: .normal)
    }
    
    @IBAction func didTapUpload() {
        delegate?.didTapUpload()
    }
    
    @IBAction func didTapContinue() {
        delegate?.didTapContinue()
    }
    
    func setCountForButton(count: Int) {
        var str = App.getString(key:"copilotapp.accidentdamage.accident.process.record.keeping.upload.photo.continue.button") ?? ""
        str = str.replacingOccurrences(of: "{number}", with: "\(count)")
        
        let continueStr = App.getString(key:"copilotapp.accidentdamage.accident.process.proceed.service.continue.button") ?? ""
        
        let title = count > 0 ? str: continueStr
        continueButton.setTitle(title, for: .normal)
    }
}
