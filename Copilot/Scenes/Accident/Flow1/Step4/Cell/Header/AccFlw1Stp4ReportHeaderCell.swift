//
//  AccFlw1Stp4ReportCell.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import UIKit

class AccFlw1Stp4ReportHeaderCell: UICollectionViewCell, Reusable {
    
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
        titleLabel.text = Strings.keepReports
        descriptionLabel.text = "\(Strings.fillReportDocuments)/n\(Strings.clickHelpReport)"
        guideLabel.text = Strings.recordKeepingGuide
    }
}
