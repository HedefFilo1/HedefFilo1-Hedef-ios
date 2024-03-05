//
//  ReqFlw2Stp3VehicleViewController.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation
import UIKit

class ReqFlw2Stp3VehicleViewController: UIViewController {
    
    var viewModel: ReqFlw2Stp3VehicleViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTextField: UITextView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: CPTextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: CPTextField!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: CPTextField!
    
    @IBOutlet weak var plakLabel: UILabel!
    @IBOutlet weak var plakTextField: CPTextField!
    
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var reasonTextField: CPTextField!
    
    @IBOutlet weak var trafficNameLabel: UILabel!
    @IBOutlet weak var trafficNameTextField: CPTextField!
    
    @IBOutlet weak var trafficPhoneLabel: UILabel!
    @IBOutlet weak var trafficPhoneTextField: CPTextField!
    
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkNameTextField: CPTextField!
    
    @IBOutlet weak var parkPhoneLabel: UILabel!
    @IBOutlet weak var parkPhoneTextField: CPTextField!
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverNameTextField: CPTextField!
    
    @IBOutlet weak var receiverPhoneLabel: UILabel!
    @IBOutlet weak var receiverPhoneTextField: CPTextField!
    
    @IBOutlet weak var receiverTCKNLabel: UILabel!
    @IBOutlet weak var receiverTCKNTextField: CPTextField!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityList: CPDropDownList!
    
    @IBOutlet weak var addFileLabel: UILabel!
    @IBOutlet weak var selectFileView: UIView!
    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var selectFileLabel: UILabel!
    @IBOutlet weak var createButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18R400)
        noteLabel.apply(.blackS14R400)
        nameLabel.apply(.blackS14R400)
        emailLabel.apply(.blackS14R400)
        phoneLabel.apply(.blackS14R400)
        plakLabel.apply(.blackS14R400)
        reasonLabel.apply(.blackS14R400)
        trafficNameLabel.apply(.blackS14R400)
        trafficPhoneLabel.apply(.blackS14R400)
        parkNameLabel.apply(.blackS14R400)
        parkPhoneLabel.apply(.blackS14R400)
        receiverNameLabel.apply(.blackS14R400)
        receiverPhoneLabel.apply(.blackS14R400)
        receiverTCKNLabel.apply(.blackS14R400)
        cityLabel.apply(.blackS14R400)
        addFileLabel.apply(.blackS14R400)
        documentNameLabel.apply(.blackS14R400)
        selectFileLabel.apply(.blackS14R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.completedVehicleOperations
       
        noteLabel.text = Strings.addNote
        noteTextField.toolbarPlaceholder = Strings.addNote
        
        nameLabel.text = Strings.nameDashSurname
        nameTextField.placeholder = Strings.enterNameSurname
        
        emailLabel.text = Strings.emailAddress
        emailTextField.placeholder = Strings.enterYourEmail
        
        phoneLabel.text = Strings.yourMobilePhone
        phoneTextField.placeholder = Strings.enterYourMobilePhone
        
        plakLabel.text = Strings.yourLicensePlate
        plakTextField.placeholder = Strings.enterYourLicensePlate
        
        reasonLabel.text = Strings.reasonConnectingVehicle
        reasonTextField.placeholder = Strings.enterReasonConnectingVehicle
        
        trafficNameLabel.text = Strings.trafficBranchName
        trafficNameTextField.placeholder = Strings.enterTrafficBranchName
        
        trafficPhoneLabel.text = Strings.trafficBranchPhone
        trafficPhoneTextField.placeholder = Strings.enterTrafficBranchPhone
        
        parkNameLabel.text = Strings.trusteeParkingName
        parkNameTextField.placeholder = Strings.enterTrusteeParkingName
        
        parkPhoneLabel.text = Strings.trusteeParkingPhone
        parkPhoneTextField.placeholder = Strings.enterTrusteeParkingPhone
        
        receiverNameLabel.text = Strings.receiverNameSurname
        receiverNameTextField.placeholder = Strings.enterReceiverNameSurname
        
        receiverPhoneLabel.text = Strings.receivingPersonPhone
        receiverPhoneTextField.placeholder = Strings.enterReceivingPersonPhone
        
        receiverTCKNLabel.text = Strings.receivingPersonTRIDNumber
        receiverTCKNTextField.placeholder = Strings.enterReceivingPersonTRIDNumber
        
        cityLabel.text = Strings.selectProvince
        cityList.title = Strings.selectProvince
        
        addFileLabel.text = Strings.addFile
        documentNameLabel.text = Strings.requiredDocumentName
        selectFileLabel.text = Strings.selectFile
        createButton.setTitle(Strings.createProcessRequest, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension ReqFlw2Stp3VehicleViewController: ReqFlw2Stp3VehicleViewModelDelegate {
    
}
