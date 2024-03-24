//
//  ReqFlw2Stp3HGSViewController.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation
import UIKit
import MobileCoreServices

class ReqFlw3Stp3HGSViewController: UIViewController {
    
    var viewModel: ReqFlw3Stp3HGSViewModelType! {
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
    
    @IBOutlet weak var proccessLabel: UILabel!
    @IBOutlet weak var proccessList: CPDropDownList!
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverNameTextField: RequestsTextField!
    
    @IBOutlet weak var receiverPhoneLabel: UILabel!
    @IBOutlet weak var receiverPhoneTextField: RequestsPhoneTextField!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextField: CPDescriptionTextField!
    
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
        //        viewModel.coordinatorDelegate?.goToSuccess(title: Strings.hgsOperations)
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
        proccessLabel.apply(.blackS14R400)
        receiverNameLabel.apply(.blackS14R400)
        receiverPhoneLabel.apply(.blackS14R400)
        addFileLabel.apply(.blackS14R400)
        documentNameLabel.apply(.blackS14R400)
        selectFileLabel.apply(.blackS14R400)
        addressLabel.apply(.blackS14R400)
        setDashedBorder()
        setTextFieldsStyle()
        
        fileNameView.layer.cornerRadius = 6
        fileNameLabel.apply(.blackS14R400)
        closeImageView.image = closeImageView.image?.withRenderingMode(.alwaysTemplate)
        closeImageView.tintColor = .greyButton
    }
    
    func setTextFieldsStyle() {
        proccessList.headView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        proccessList.titleLabelTop?.constant = 16
        proccessList.titleLabel.apply(.custom(.textFieldGreyText, .regular, 14))
    }
    
    func setTexts() {
        titleLabel.text = Strings.hgsOperations
        
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
        
        proccessLabel.text = Strings.processType
        proccessList.title = Strings.enterProcessType
        
        receiverNameLabel.text = Strings.nameSurnameOfHGSPerson
        receiverNameTextField.placeholder = Strings.enterNameSurnameOfHGSPerson
        
        receiverPhoneLabel.text = Strings.phoneOfHGSPerson
        receiverPhoneTextField.placeholder = Strings.enterPhoneOfHGSPerson
        
        addressLabel.text = Strings.deliveryAddress
        addressTextField.placeholder = Strings.enterDeliveryAddress
        
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
        addressTextField.delegate = self
        proccessList.delegate = self
        nameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        plateTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        receiverNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        receiverPhoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        setButtonActivation()
    }
    
    func setButtonActivation() {
        let note = noteTextField.text.count > 0
        let address = addressTextField.text.count > 0
        //        let name = nameTextField.pureTextCount > 0
        //        let email = emailTextField.isValidText
        //        let phone = phoneTextField.isValidText
        //        let plate = plateTextField.pureTextCount > 0
        let proccess = proccessList.hasSelectedItem
        let receiverName = receiverNameTextField.pureTextCount > 0
        let receiverPhone = receiverPhoneTextField.isValidText
        
        let result = note && address && proccess && receiverName && receiverPhone
        createButton.isEnabled = result
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapCreate() {
        guard let index = proccessList.selectedIndex else { return }
        let ogsHgsType = viewModel.ogsHgsTypes[index].field
        
        viewModel.createCase(licensePlate: plateTextField.text ?? "",
                             note: noteTextField.text,
                             nameSurname: nameTextField.text ?? "",
                             receiverPersonName: receiverNameTextField.text ?? "",
                             receiverPersonPhone: receiverPhoneTextField.text ?? "",
                             ogsHgsType: ogsHgsType,
                             deliveryAddress: addressTextField.text)
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

extension ReqFlw3Stp3HGSViewController: CPDescriptionTextFieldDelegate {
    func didEditingChanged() {
        setButtonActivation()
    }
}

extension ReqFlw3Stp3HGSViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        guard let data = try? Data(contentsOf: selectedFileURL) else { return }
        viewModel.sendFile(data: data)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // User cancelled the document picker
    }
    
}

extension ReqFlw3Stp3HGSViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            fileNameLabel.text = url.lastPathComponent
            showFileNameView()
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

extension ReqFlw3Stp3HGSViewController: CPDropDownListDelegate {
    func superViewForDropDown(in dropDownList: CPDropDownList) -> UIView? {
        return view
    }
    
    func numberOfItems(in dropDownList: CPDropDownList) -> Int {
        return viewModel.ogsHgsTypes.count
    }
    
    func CPDropDownList(_ dropDownList: CPDropDownList, titleFor index: Int) -> String {
        return viewModel.ogsHgsTypes[index].title
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

extension ReqFlw3Stp3HGSViewController: ReqFlw3Stp3HGSViewModelDelegate {
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
