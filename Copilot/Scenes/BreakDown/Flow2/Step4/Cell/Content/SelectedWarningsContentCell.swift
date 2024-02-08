//
//  SelectedWarningsContentCell.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import UIKit

protocol SelectedWarningsContentCellDelegate: AnyObject {
    func didTapShowLocation()
    func didTapChooseAnother()
    func didTapServices()
    func didTapCall()
}

class SelectedWarningsContentCell: UICollectionViewCell, Reusable {
    
    weak var delegate: SelectedWarningsContentCellDelegate?
    
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var getWellLabel: UILabel!
    @IBOutlet weak var donotStartLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var showLocationLabel: UILabel!
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
        headView.layer.cornerRadius = 10
        headView.layer.borderWidth = 1
        headView.layer.borderColor = UIColor.borderColor.cgColor
        
        getWellLabel.apply(.blackS20B700)
        donotStartLabel.apply(.themeS14B700)
        descriptionLabel.apply(.greyS16R400)
        locationLabel.apply(.greyS14R400)
        showLocationLabel.apply(.themeS12B700)
        callView.layer.borderColor = UIColor.theme.cgColor
        callView.layer.borderWidth = 1
        callView.layer.cornerRadius = 10
        callLabel.apply(.themeS16B700)
    }
    
    func setTexts() {
        getWellLabel.text = Strings.getWellSoon
        donotStartLabel.text = Strings.donotStartVehicle
        descriptionLabel.text = Strings.towTruckSendingDescription
        showLocationLabel.text = Strings.showLocation
        callLabel.text = Strings.callSolutionCenter
        chooseLightButton.setTitle(Strings.chooseAnotherLight, for: .normal)
        servicesButton.setTitle(Strings.proceedServiceSelection, for: .normal)
        
        let text1 = AttributedText(text: "\(Strings.warning): ", type: .themeS12B700)
        let text2 = AttributedText(text: Strings.breakdownWarrningMessage, type: .greyS12R400)
        warningLabel.attributedText = AttributedText.createString(texts: [text1, text2])
    }
    
    @IBAction func didTapShowLocation() {
        delegate?.didTapShowLocation()
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
