//
//  AccFlw1Stp4ReportCell.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import UIKit

protocol AccFlw1Stp4ReportHeaderCellDelegate: AnyObject {
    func didTapGuilde()
}

class AccFlw1Stp4ReportHeaderCell: UICollectionViewCell, Reusable {
    weak var delegate: AccFlw1Stp4ReportHeaderCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setTexts()
        
    }
    
    func setup() {
        titleLabel.apply(.blackS20B700)
        descriptionLabel.apply(.greyS12R400)
        guideLabel.apply(.themeS14B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.title")
        descriptionLabel.text = "\(Strings.fillReportDocuments)/n\(Strings.clickHelpReport)"
        guideLabel.text = Strings.recordKeepingGuide
    }
    
    @IBAction func didTapGuide() {
        delegate?.didTapGuilde()
    }
}
