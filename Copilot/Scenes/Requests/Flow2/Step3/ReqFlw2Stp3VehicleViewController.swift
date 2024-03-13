//
//  ReqFlw2Stp3VehicleViewController.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation
import UIKit
import MobileCoreServices

class ReqFlw2Stp3VehicleViewController: UIViewController {
    
    var viewModel: ReqFlw2Stp3VehicleViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTextField: CPDescriptionTextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: CPTextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: CPTextField!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: CPTextField!
    
    @IBOutlet weak var plateLabel: UILabel!
    @IBOutlet weak var plateTextField: CPTextField!
    
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
        addTextFieldsTargets()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18R400)
        noteLabel.apply(.blackS14R400)
        nameLabel.apply(.blackS14R400)
        emailLabel.apply(.blackS14R400)
        phoneLabel.apply(.blackS14R400)
        plateLabel.apply(.blackS14R400)
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
        setDashedBorder()
        setTextFieldsStyle()
    }
    
    func setTextFieldsStyle() {
        var array = [nameTextField, emailTextField, phoneTextField, plateTextField, reasonTextField, trafficNameTextField]
        
        array.append(contentsOf: [trafficPhoneTextField, parkNameTextField, parkPhoneTextField, receiverNameTextField, receiverPhoneTextField, receiverTCKNTextField])
        for item in array {
            item?.apply(.custom(.textFieldGreyText, .regular, 14))
            item?.contentView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        }
    }
    
    func setTexts() {
        titleLabel.text = Strings.completedVehicleOperations
        
        noteLabel.text = Strings.addNote
        noteTextField.placeholder = Strings.enterNote
        
        nameLabel.text = Strings.nameDashSurname
        nameTextField.placeholder = Strings.enterNameSurname
        
        emailLabel.text = Strings.emailAddress
        emailTextField.placeholder = Strings.enterYourEmail
        
        phoneLabel.text = Strings.yourMobilePhone
        phoneTextField.placeholder = Strings.enterYourMobilePhone
        
        plateLabel.text = Strings.yourLicensePlate
        plateTextField.placeholder = Strings.enterYourLicensePlate
        
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
    
    func setDashedBorder() {
        let shapeLayer = CAShapeLayer()
        let bounds = selectFileView.bounds
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.dashedBorder.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 6).cgPath
        
        selectFileView.layer.addSublayer(shapeLayer)
    }
    
    func addTextFieldsTargets() {
        
        noteTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        plateTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        reasonTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        trafficNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        trafficPhoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        parkNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        parkPhoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        receiverNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        receiverPhoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        receiverTCKNTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        setButtonActivation()
    }
    
    func setButtonActivation() {
        let note = noteTextField.text.count > 0
        let name = nameTextField.pureTextCount > 0
        let email = emailTextField.pureTextCount > 0
        let phone = phoneTextField.pureTextCount > 0
        let plak = plateTextField.pureTextCount > 0
        let reason = reasonTextField.pureTextCount > 0
        let trafficName = trafficNameTextField.pureTextCount > 0
        let trafficPhone = trafficPhoneTextField.pureTextCount > 0
        let parkName = parkNameTextField.pureTextCount > 0
        let parkPhone = parkPhoneTextField.pureTextCount > 0
        let receiverName = receiverNameTextField.pureTextCount > 0
        let receiverPhone = receiverPhoneTextField.pureTextCount > 0
        let receiverTCKN = receiverTCKNTextField.pureTextCount > 0
        
        let result = note && name && email && phone && plak && reason && trafficName && trafficPhone && parkName && parkPhone && receiverName && receiverPhone && receiverTCKN
        createButton.isEnabled = result
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapSendFile() {
        //        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        //        documentPicker.delegate = self
        //        present(documentPicker, animated: true, completion: nil)
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func didTapCreate() {
        let reason = reasonTextField.text ?? ""
        viewModel.createCase(licensePlate: plateTextField.text ?? "",
                             note: noteTextField.text,
                             nameSurname: nameTextField.text ?? "",
                             impoundCarReason: reason,
                             description: "",
                             trafficBranchName: trafficNameTextField.text ?? "",
                             trafficBranchPhone: trafficPhoneLabel.text ?? "",
                             carParkName: parkNameTextField.text ?? "",
                             carParkPhone: parkPhoneTextField.text ?? "",
                             deliveryPersonName: receiverNameTextField.text ?? "",
                             deliveryPersonPhone: receiverPhoneTextField.text ?? "",
                             deliveryAddress: "")
    }
}

extension ReqFlw2Stp3VehicleViewController: CPDescriptionTextFieldDelegate {
    func didEditingChanged() {
        setButtonActivation()
    }
}

extension ReqFlw2Stp3VehicleViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        picker.dismiss(animated: true)
        guard let data = tempImage.pngData() else { return }
        Loading.shared.show(presentingView: self.view)
        viewModel.sendFile(data: data)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ReqFlw2Stp3VehicleViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        guard let data = try? Data(contentsOf: selectedFileURL) else { return }
        viewModel.sendFile(data: data)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // User cancelled the document picker
    }
}

extension ReqFlw2Stp3VehicleViewController: ReqFlw2Stp3VehicleViewModelDelegate {
    
}
