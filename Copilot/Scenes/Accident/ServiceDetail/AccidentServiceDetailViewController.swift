//
//  AccidentServiceDetailViewController.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation
import UIKit

class AccidentServiceDetailVController: UIViewController {
    
    var viewModel: AccidentServiceDetailViewModelType! {
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
    @IBOutlet weak var dateAndTimeView: UIView!
    @IBOutlet weak var selectRandevuLabel: UILabel!
    @IBOutlet weak var randevuDescriptionLabel: UILabel!
    @IBOutlet weak var selectDayLabel: UILabel!
    @IBOutlet weak var selectTimeLabel: UILabel!
    @IBOutlet weak var continueButton: CPButton!
    @IBOutlet weak var dateChooseView: CPDateChooseView!
    @IBOutlet weak var timeChooseView: CPTimeChooseView!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        setAppointment()
        setService()
        continueButton.isEnabled = viewModel.towTruck
        if viewModel.towTruck {
            dateAndTimeView.isHidden = true
        }
        
        #if DEV_DEBUG
//        viewModel.coordinatorDelegate?.goToAccidentSuccessRandevu(service: viewModel.service!, date: nil, accidentType: viewModel.accidentType)
        #endif
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
        statusView.clipsToBounds = true
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
        selectRandevuLabel.apply(.blackS14B700)
        randevuDescriptionLabel.apply(.greyS12R400)
        selectDayLabel.apply(.blackS12B700)
        selectTimeLabel.apply(.blackS12B700)
        continueButton.isSmallFontSize = true
        statusView.layer.cornerRadius = 12
        statusView.backgroundColor = .appYellow
        statusLabel.apply(.whiteS12B700)
    }
    
    func setTexts() {
        titleLabel.text = viewModel.service?.name
//        desciptionLabel.text = Strings.breakdownServicesDescription
        desciptionLabel.text = ""
        mapButtonLabel.text = Strings.showOnMap
        selectRandevuLabel.text = Strings.selectAppointmentDay
        randevuDescriptionLabel.text = Strings.oneAppointment15Days
        selectDayLabel.text = Strings.selectDay
        selectTimeLabel.text = Strings.selectTime
        continueButton.setTitle(Strings.devamEt, for: .normal)
        continueButton.isSmallFontSize = true
        dateLabel.text = Strings.serviceWorkingHours
    }
    
    func setButtonActivation() {
        if viewModel.towTruck {
            continueButton.isEnabled = true
        } else {
            let date = dateChooseView.date != nil
            let time = timeChooseView.timeSelected
            continueButton.isEnabled = date && time
        }
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapLocation() {
        if let lat = viewModel.service?.latitude, let lon = viewModel.service?.longitude {
            showActionSheet(lat: lat, lon: lon)
        }
    }
    
    @IBAction func didContinue() {
        if viewModel.towTruck {
            viewModel.createTowTruckRandevu()
            return
        }
        guard let date = dateChooseView.date else { return }
        let hour = timeChooseView.seletedHour ?? ""
        let minute = timeChooseView.seletedMinute ?? ""
        viewModel.createRandevu(with: date, hour: hour, minute: minute)
    }
    
//    func setAppointment() {
//        guard let item = viewModel.appointment else { return }
//        titleLabel.text = item.supplierName ?? Strings.service
//        nameLabel.text = item.supplierName
//        addressLabel.text = item.address
//        phoneLabel.text = item.supplierPhone
//        let type = item.appointmentStatus
//        if type == .appointmentApproved {
//            statusView.backgroundColor = .textSuccess
//            statusLabel.text = Strings.approved
//            desciptionLabel.text = Strings.tireRepairappointmentCreated
//        } else {
//            statusView.backgroundColor = .appYellow
//            statusLabel.text = Strings.waitingToApprove
//            desciptionLabel.text = Strings.tireRepairAwaitingConfirmation
//        }
//
//        dateChooseView.setDate(strDate: item.appointmentDate ?? "")
//        timeChooseView.set(hourNumber: item.hourOfDate, minuteNumber: item.minetusOfDate)
//        setButtonActivation()
//    }
    
    func setService() {
        guard let item = viewModel.service else { return }
        titleLabel.text = item.name
        nameLabel.text = item.name
        phoneLabel.text = item.phone
        addressLabel.text = item.address
        statusView.isHidden = true
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

extension AccidentServiceDetailVController: CPTimeChooseViewDelegate,
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
    
    func didSelect(_: CalendarViewController, date: Date) {
        dateChooseView.date = date
        setButtonActivation()
    }
}
extension AccidentServiceDetailVController: AccidentServiceDetailVMdlDlgt {
    
}
