//
//  SelectedWarningsButtonsCell.swift
//  Copilot
//
//  Created by Jamal on 2/9/24.
//

import UIKit

protocol SelectedWarningsButtonsCellDelegate: AnyObject {
    func didTapChooseAnother()
    func didTapServices()
    func didTapCall()
}

class SelectedWarningsButtonsCell: UICollectionViewCell, Reusable {
    
    weak var delegate: SelectedWarningsButtonsCellDelegate?

    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var chooseLightButton: CPLightButton!
    @IBOutlet weak var servicesButton: CPButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI() {
        applyStyle()
        setTexts()
        servicesButton.isEnabled = true
    }
    
    func applyStyle() {
        callView.layer.borderColor = UIColor.theme.cgColor
        callView.layer.borderWidth = 1
        callView.layer.cornerRadius = 10
        callLabel.apply(.themeS16B700)
    }
    
    func setTexts() {
        callLabel.text = Strings.callSolutionCenter
        chooseLightButton.setTitle(Strings.chooseAnotherLight, for: .normal)
        servicesButton.setTitle(App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.engine.service.choice.button"), for: .normal)
        
        let text1 = AttributedText(text: "\(Strings.warning): ", type: .themeS12B700)
        let text2 = AttributedText(text: Strings.breakdownWarrningMessage, type: .greyS12R400)
        warningLabel.attributedText = AttributedText.createString(texts: [text1, text2])
    }
    
    @IBAction func didTapChooseAnother() {
        delegate?.didTapChooseAnother()
    }
    
    @IBAction func didTapServices() {
        delegate?.didTapServices()
    }
    
    @IBAction func didTapCall() {
        delegate?.didTapCall()
    }
}
