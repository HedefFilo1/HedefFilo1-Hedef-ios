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
    @IBOutlet weak var emailTextField: CPEmailTextField!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: CPPhoneTextField!
    
    @IBOutlet weak var plateLabel: UILabel!
    @IBOutlet weak var plateTextField: CPTextField!
    
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var reasonList: CPDropDownList!
    
    @IBOutlet weak var trafficNameLabel: UILabel!
    @IBOutlet weak var trafficNameTextField: CPTextField!
    
    @IBOutlet weak var trafficPhoneLabel: UILabel!
    @IBOutlet weak var trafficPhoneTextField: CPPhoneTextField!
    
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkNameTextField: CPTextField!
    
    @IBOutlet weak var parkPhoneLabel: UILabel!
    @IBOutlet weak var parkPhoneTextField: CPPhoneTextField!
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverNameTextField: CPTextField!
    
    @IBOutlet weak var receiverPhoneLabel: UILabel!
    @IBOutlet weak var receiverPhoneTextField: CPPhoneTextField!
    
    @IBOutlet weak var receiverTCKNLabel: UILabel!
    @IBOutlet weak var receiverTCKNTextField: CPTextField!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityList: CPDropDownList!
    
    @IBOutlet weak var addFileLabel: UILabel!
    @IBOutlet weak var selectFileView: UIView!
    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var selectFileLabel: UILabel!
    
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileNameView: UIView!
    @IBOutlet weak var closeImageView: UIImageView!
    
    @IBOutlet weak var createButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        #if DEV_DEBUG
        viewModel.coordinatorDelegate?.goToSuccess(title: Strings.completedVehicleOperations)
        #endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        addTextFieldsTargets()
        hideFileNameView()
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
        var array = [nameTextField, emailTextField, phoneTextField, plateTextField, trafficNameTextField]
        
        array.append(contentsOf: [trafficPhoneTextField, parkNameTextField, parkPhoneTextField, receiverNameTextField, receiverPhoneTextField, receiverTCKNTextField])
        for item in array {
            item?.apply(.custom(.textFieldGreyText, .regular, 14))
            item?.contentView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        }
        
        phoneTextField.keyboardType = .phonePad
        trafficPhoneTextField.keyboardType = .phonePad
        parkPhoneTextField.keyboardType = .phonePad
        receiverPhoneTextField.keyboardType = .phonePad
        
        reasonList.headView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        reasonList.titleLabelTop?.constant = 16
        reasonList.titleLabel.apply(.custom(.textFieldGreyText, .regular, 14))
        
        cityList.headView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        cityList.titleLabelTop?.constant = 16
        cityList.titleLabel.apply(.custom(.textFieldGreyText, .regular, 14))
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
        reasonList.title = Strings.enterReasonConnectingVehicle
        
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
        
        fileNameView.layer.cornerRadius = 6
        fileNameLabel.apply(.blackS14R400)
        closeImageView.image = closeImageView.image?.withRenderingMode(.alwaysTemplate)
        closeImageView.tintColor = .greyButton
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
        reasonList.delegate = self
        cityList.delegate = self
        receiverTCKNTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        plateTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
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
        let email = emailTextField.isValidText
        let phone = phoneTextField.isValidText
        let plak = plateTextField.pureTextCount > 0
        let reason = reasonList.hasSelectedItem
        let city = cityList.hasSelectedItem
        let trafficName = trafficNameTextField.pureTextCount > 0
        let trafficPhone = trafficPhoneTextField.isValidText
        let parkName = parkNameTextField.pureTextCount > 0
        let parkPhone = parkPhoneTextField.isValidText
        let receiverName = receiverNameTextField.pureTextCount > 0
        let receiverPhone = receiverPhoneTextField.isValidText
        let receiverTCKN = receiverTCKNTextField.pureTextCount > 0
        
        let result = note && name && email && phone && plak && reason && trafficName && trafficPhone && parkName && parkPhone && receiverName && receiverPhone && receiverTCKN && city
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
        guard let reasonIndex = reasonList.selectedIndex,
              let cityIndex = cityList.selectedIndex else { return }
        let reason = viewModel.reasons[reasonIndex].field
        let city = viewModel.cities[cityIndex].name
        
        viewModel.createCase(licensePlate: plateTextField.text ?? "",
                             note: noteTextField.text,
                             nameSurname: nameTextField.text ?? "",
                             impoundCarReason: reason,
                             description: "",
                             trafficBranchName: trafficNameTextField.text ?? "",
                             trafficBranchPhone: trafficPhoneTextField.number,
                             carParkName: parkNameTextField.text ?? "",
                             carParkPhone: parkPhoneTextField.number,
                             deliveryPersonName: receiverNameTextField.text ?? "",
                             deliveryPersonPhone: receiverPhoneTextField.number,
                             city: city,
                             deliveryAddress: "")
    }
    
    @IBAction func didTapCloseFile() {
        viewModel.uploadedFileInfo = nil
        removeSelectedFile()
    }
    
    func hideFileNameView() {
        fileNameView.heightConstraint?.constant = 0
    }
    
    func showFileNameView() {
        fileNameView.heightConstraint?.constant = 40
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
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            fileNameLabel.text = url.lastPathComponent
            showFileNameView()
            //                fileType = url.pathExtension
        }
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

extension ReqFlw2Stp3VehicleViewController: CPDropDownListDelegate {
    func superViewForDropDown(in dropDownList: CPDropDownList) -> UIView? {
        return view
    }
    
    func numberOfItems(in dropDownList: CPDropDownList) -> Int {
        if dropDownList == cityList {
            return viewModel.cities.count
        }
        return viewModel.reasons.count
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, titleFor index: Int) -> String {
        if dropDownList == cityList {
            return viewModel.cities[index].name
        }
        return viewModel.reasons[index].title
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, didSelect index: Int) {
        setButtonActivation()
    }
    
    func willOpen(_ dropDownList: CPDropDownList) {
        
    }
    
    func willDismiss(_ dropDownList: CPDropDownList) {
        
    }
    
    func didDismiss(_ dropDownList: CPDropDownList) {
        
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, shouldSelect index: Int) -> Bool {
        false
    }
}

extension ReqFlw2Stp3VehicleViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        return range.location < 11
    }
}

extension ReqFlw2Stp3VehicleViewController: ReqFlw2Stp3VehicleViewModelDelegate {
    func removeSelectedFile() {
        viewModel.uploadedFileInfo = nil
        fileNameLabel.text = ""
        hideFileNameView()
    }
}
