//
//  ServiceDetailViewController.swift
//  Copilot
//
//  Created by Jamal on 1/2/24.
//

import Foundation
import UIKit

class ServiceDetailViewController: UIViewController {

    var viewModel: ServiceDetailViewModelType! {
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
    @IBOutlet weak var selectRandevuLabel: UILabel!
    @IBOutlet weak var randevuDescriptionLabel: UILabel!
    @IBOutlet weak var selectDayLabel: UILabel!
    @IBOutlet weak var selectTimeLabel: UILabel!
    @IBOutlet weak var continueButton: CPButton!
    @IBOutlet weak var dateChooseView: CPDateChooseView!
    @IBOutlet weak var timeChooseView: CPTimeChooseView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        continueButton.isEnabled = false
        dateChooseView.delegate = self
        timeChooseView.delegate = self
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
        selectRandevuLabel.apply(.blackS14B700)
        randevuDescriptionLabel.apply(.greyS12R400)
        selectDayLabel.apply(.blackS12B700)
        selectTimeLabel.apply(.blackS12B700)
        continueButton.isSmallFontSize = true
    }
    
    func setTexts() {
        titleLabel.text = viewModel.service?.name
        desciptionLabel.text = Strings.selectTimeToRepair
        mapButtonLabel.text = Strings.showOnMap
        selectRandevuLabel.text = Strings.selectAppointmentDay
        randevuDescriptionLabel.text = Strings.oneAppointment15Days
        selectDayLabel.text = Strings.selectDay
        selectTimeLabel.text = Strings.selectTime
        continueButton.setTitle(Strings.devamEt, for: .normal)
    }
    
    func setButtonActivation() {
        let date = dateChooseView.date != nil
        let time = timeChooseView.timeSelected
        continueButton.isEnabled = date && time
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didContinue() {
//        viewModel.getBack()
    }
}

extension ServiceDetailViewController: CPTimeChooseViewDelegate,
                                       CPDateChooseViewDelegate,
                                       CalendarViewControllerDelegate {
    
    func didTap(_: CPDateChooseView) {
        viewModel.presentCalendar(delegate: self)
    }
    
    func didTap(_: CPTimeChooseView) {
        
    }
    
    func didSelect(_: CPTimeNumberChooseView, number: String) {
        setButtonActivation()
    }
    
    func superViewForDropDown(in cpTimeChooseView: CPTimeNumberChooseView) -> UIView? {
        return view
    }
    
    func didSelect(date: Date) {
        dateChooseView.date = date
        setButtonActivation()
    }
}

extension ServiceDetailViewController: ServiceDetailViewModelDelegate {
    
}
