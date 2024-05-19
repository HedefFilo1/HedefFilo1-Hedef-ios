//
//  AccFlw5Stp3ContentCell.swift
//  Copilot
//
//  Created by Jamal on 2/23/24.
//

import UIKit

class AccFlw5Stp3ContentCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var declareLabel: UILabel!
    @IBOutlet weak var licenceLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setTexts()
        
    }
    
    func setup() {
        titleLabel.apply(.themeS14B700)
        descriptionLabel.apply(.themeS12R400)
        declareLabel.apply(.blackS14B700)
        licenceLabel.apply(.blackS14B700)
        photoLabel.apply(.blackS14B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.declaration.notification.warning")
        setDescriptionLabel()
       
        let str = App.getString(key: "copilotapp.accidentdamage.accident.process.declaration.notification.declaration") ?? ""
        declareLabel.text = "\(CodeStrings.bullet) \(str)"
        
        let str2 = App.getString(key: "copilotapp.accidentdamage.accident.process.declaration.notification.driving.license") ?? ""
        licenceLabel.text = "\(CodeStrings.bullet) \(str2)"
        
        let str3 = App.getString(key: "copilotapp.accidentdamage.accident.process.declaration.notification.crime.scene.photo") ?? ""
        photoLabel.text = "\(CodeStrings.bullet) \(str3)"
    }
    
    func setDescriptionLabel() {
        let part1 = AttributedText(text: "\(Strings.callPoliceDescription) ", type: .themeS12R400)
        let part2 = AttributedText(text: Strings.KeepAReportUppercased, type: .themeS14B700)
        descriptionLabel.attributedText = AttributedText.createString(texts: [part1, part2])
    }

}
