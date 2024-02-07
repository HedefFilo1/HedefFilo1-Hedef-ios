//
//  WarningLightsFooterCell.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import UIKit

protocol WarningLightsFooterCellDelegate: AnyObject {
    func didTabBack()
    func didTapGoToGuide()
}

class WarningLightsFooterCell: UICollectionViewCell, Reusable {
    
    weak var delegate: WarningLightsFooterCellDelegate?
    @IBOutlet weak var backButton: CPLightButton!
    @IBOutlet weak var guidLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        guidLabel.apply(.themeS14B700)
        backButton.setTitle(Strings.turnBack, for: .normal)
        guidLabel.text = Strings.goToWarningLightsGuide
    }
    
    @IBAction func didTapBack() {
        delegate?.didTabBack()
    }
    
    @IBAction func didTapGuide() {
        delegate?.didTapGoToGuide()
    }
}
 
