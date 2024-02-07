//
//  BrkdwnFlw1Stp5ServiceDetailVController.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation
import UIKit

class BrkdwnFlw1Stp5ServiceDetailVController: UIViewController {

    var viewModel: BrkdwnFlw1Stp5ServiceDetailViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mapButtonView: UIView!
    @IBOutlet weak var mapButtonLabel: UILabel!
    @IBOutlet weak var continueButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setService()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        continueButton.isEnabled = true
        phoneLabel.text = ""
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        desciptionLabel.apply(.greyS14R400)
        nameLabel.apply(.blackS16B700)
        phoneLabel.apply(.blackS12R400)
        addressLabel.apply(.greyS12R400)
        dateLabel.apply(.greyS12R400)
        mapButtonView.layer.cornerRadius = 10
        mapButtonView.layer.borderWidth = 1
        mapButtonView.layer.borderColor = UIColor.theme.cgColor
        mapButtonLabel.apply(.themeS12B700)
    }
    
    func setTexts() {
        titleLabel.text = viewModel.service?.name
        desciptionLabel.text = Strings.selectTimeToRepair
        mapButtonLabel.text = Strings.showOnMap
        continueButton.setTitle(Strings.devamEt, for: .normal)
        continueButton.isSmallFontSize = true
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapLocation() {
        guard let item = viewModel.service else { return }
        showActionSheet(lat: item.latitude ?? 0, lon: item.longitude ?? 0)
    }
    
    @IBAction func didContinue() {
        viewModel.createRandevu()
    }
    
    func setService() {
        guard let item = viewModel.service else { return }
        titleLabel.text = item.name
        nameLabel.text = item.name
        phoneLabel.text = item.phone
        addressLabel.text = item.address
    }
    
    func showActionSheet(lat: Double, lon: Double) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let firstAction: UIAlertAction = UIAlertAction(title: Strings.map, style: .default) { [weak self] _ in
            self?.viewModel.openAppleMap(latitude: lat, longitude: lon)
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: Strings.googleMap, style: .default) { [weak self] _ in
            self?.viewModel.openGoogleMap(latitude: lat, longitude: lon)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: Strings.cancel, style: .cancel)
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
}

extension BrkdwnFlw1Stp5ServiceDetailVController: BrkdwnFlw1Stp5ServiceDetailVMdlDlgt {
    
}
