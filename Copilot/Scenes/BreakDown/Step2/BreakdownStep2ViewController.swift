//
//  BreakdownStep2Step2ViewController.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation
import UIKit

class BreakdownStep2ViewController: UIViewController {
    
    var viewModel: BreakdownStep2ViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getWellLabel: UILabel!
    @IBOutlet weak var donotStartLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var showLocationLabel: UILabel!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
#if DEV_DEBUG
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
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
        titleLabel.text = Strings.breakDownOperations
        getWellLabel.text = Strings.getWellSoon
        donotStartLabel.text = Strings.donotStartVehicle
        descriptionLabel.text = Strings.breakdownStep2Description
        showLocationLabel.text = Strings.showLocation
        callLabel.text = Strings.callSolutionCenter
      
        let text1 = AttributedText(text: "\(Strings.warning): ",type: .themeS12B700)
        let text2 = AttributedText(text: Strings.breakdownWarrningMessage,type: .greyS12R400)
        warningLabel.attributedText = AttributedText.createString(texts: [text1, text2])
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapShowLocation() {
//        viewModel.getBack()
    }
    
    @IBAction func didTapGetBackToHome() {
        viewModel.getBackToHome()
    }
    
    @IBAction func didTapCall() {
        
    }
    
}

extension BreakdownStep2ViewController: BreakdownStep2ViewModelDelegate {
    
}
