//
//  ReqFlw2Stp3VehicleViewController.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation
import UIKit
import MobileCoreServices
import Photos

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
    @IBOutlet weak var nameTextField: RequestsTextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: RequestsTextField!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: RequestsPhoneTextField!
    
    @IBOutlet weak var plateLabel: UILabel!
    @IBOutlet weak var plateTextField: RequestsTextField!
    
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var reasonList: RequestsDropDownList!
    
    @IBOutlet weak var trafficNameLabel: UILabel!
    @IBOutlet weak var trafficNameTextField: RequestsTextField!
    
    @IBOutlet weak var trafficPhoneLabel: UILabel!
    @IBOutlet weak var trafficPhoneTextField: RequestsPhoneTextField!
    
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkNameTextField: RequestsTextField!
    
    @IBOutlet weak var parkPhoneLabel: UILabel!
    @IBOutlet weak var parkPhoneTextField: RequestsPhoneTextField!
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverNameTextField: RequestsTextField!
    
    @IBOutlet weak var receiverPhoneLabel: UILabel!
    @IBOutlet weak var receiverPhoneTextField: RequestsPhoneTextField!
    
    @IBOutlet weak var receiverTCKNLabel: UILabel!
    @IBOutlet weak var receiverTCKNTextField: RequestsTextField!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityList: RequestsDropDownList!
    
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
        viewModel.getProfile()
        
        #if DEV_DEBUG
//        viewModel.coordinatorDelegate?.goToSuccess(title: Strings.completedVehicleOperations)
        #endif
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
        receiverTCKNTextField.keyboardType = .numberPad
        
        reasonList.headView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        reasonList.titleLabelTop?.constant = 16
        reasonList.titleLabel.apply(.custom(.textFieldGreyText, .regular, 14))
        
        cityList.headView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        cityList.titleLabelTop?.constant = 16
        cityList.titleLabel.apply(.custom(.textFieldGreyText, .regular, 14))
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.button")
        
        noteLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.note")
        noteTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.note.enter")
        nameLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.name.surname")
        nameTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.name.surname.enter")
        
        emailLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.email")
        emailTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.email.enter")
        
        phoneLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.phone.number")
        phoneTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.phone")
        
        plateLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.plate")
        plateTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.plate.enter")
        
        reasonLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.reason.vehicle.attachment")
        reasonList.title = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.reason.vehicle.attachment.enter") ?? ""
        
        trafficNameLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.traffic.department")
        trafficNameTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.traffic.department.enter")
        
        trafficPhoneLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.traffic.department.phone")
        
        let text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.traffic.department.phone.enter")
        trafficPhoneTextField.placeholder = text
        
        parkNameLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.parking.name")
        parkNameTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.parking.name.enter")
        
        parkPhoneLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.parking.name.phone")
        parkPhoneTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.parking.name.phone.enter")
        
        receiverNameLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.person.receive.name.surname")
        receiverNameTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.person.receive.name.surname.enter")
        
        receiverPhoneLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.person.receive.name.surname.phone")
        receiverPhoneTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.person.receive.name.surname.phone.enter")
        
        receiverTCKNLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.person.receive.id")
        receiverTCKNTextField.placeholder = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.person.receive.id.enter")
        
        cityLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.select.province")
        cityList.title = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.select.province") ?? ""
        
        addFileLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.attach.file.document.select")
        
        documentNameLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.attach.file.document.name")
        selectFileLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.attach.file.document.select")
        
        fileNameView.layer.cornerRadius = 6
        fileNameLabel.apply(.blackS14R400)
        closeImageView.image = closeImageView.image?.withRenderingMode(.alwaysTemplate)
        closeImageView.tintColor = .greyButton
        let title = App.getString(key: "copilotapp.demandprocessual.processual.demand.towed.vehicle.operation.create.process.request.button")
        createButton.setTitle(title, for: .normal)
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
        receiverTCKNTextField.validationDelegate = self
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
        let reason = reasonList.hasSelectedItem
        let city = cityList.hasSelectedItem
        let trafficName = trafficNameTextField.pureTextCount > 0
        let trafficPhone = trafficPhoneTextField.isValidText
        let parkName = parkNameTextField.pureTextCount > 0
        let parkPhone = parkPhoneTextField.isValidText
        let receiverName = receiverNameTextField.pureTextCount > 0
        let receiverPhone = receiverPhoneTextField.isValidText
        let receiverTCKN = receiverTCKNTextField.isValidText
        
        let result = note && reason && trafficName && trafficPhone && parkName && parkPhone && receiverName && receiverPhone && receiverTCKN && city
        createButton.isEnabled = result
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapSendFile() {
        //        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        //        documentPicker.delegate = self
        //        present(documentPicker, animated: true, completion: nil)
        App.checkPhotoLibraryPermission { [weak self] in
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self?.present(imagePickerController, animated: true, completion: nil)
        }
        
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
                             receiverPersonTC: receiverTCKNTextField.text ?? "",
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

extension ReqFlw2Stp3VehicleViewController: UITextFieldDelegate, CPValidatableTextFieldDelegate {
   
    func validate(textField: UITextField) -> Bool {
        let count = textField.text?.count ?? 0
        return count == 11
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        return range.location < 11
    }
}

extension ReqFlw2Stp3VehicleViewController: ReqFlw2Stp3VehicleViewModelDelegate {
    
    func setProfile() {
        guard let profile = viewModel.profile else { return }
        nameTextField.disable(withText: profile.nameSurname)
        emailTextField.disable(withText: profile.email)
        phoneTextField.disable(withText: profile.phoneNumber)
        plateTextField.disable(withText: profile.plateNumber)
    }
    
    func removeSelectedFile() {
        viewModel.uploadedFileInfo = nil
        fileNameLabel.text = ""
        hideFileNameView()
    }
}
