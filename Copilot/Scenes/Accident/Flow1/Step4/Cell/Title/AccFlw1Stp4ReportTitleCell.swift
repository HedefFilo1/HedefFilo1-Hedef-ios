//
//  AccFlw1Stp4ReportTitleCell.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import UIKit

protocol AccFlw1Stp4ReportTitleCellDelegate: AnyObject {
    func didTabSampleButton()
}

class AccFlw1Stp4ReportTitleCell: UICollectionViewCell, Reusable {
    weak var delegate: AccFlw1Stp4ReportTitleCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.apply(.blackS14B700)
        buttonLabel.apply(.custom(.theme, .medium, 12))
        buttonLabel.text = Strings.minuteSample
    }

    @IBAction func didTapButton() {
        delegate?.didTabSampleButton()
    }
    
}
