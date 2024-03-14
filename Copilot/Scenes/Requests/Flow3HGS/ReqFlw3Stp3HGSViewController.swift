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
    @IBOutlet weak var nameTextField: CPTextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: CPTextField!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: CPTextField!
    
    @IBOutlet weak var plakLabel: UILabel!
    @IBOutlet weak var plakTextField: CPTextField!
    
    @IBOutlet weak var proccessLabel: UILabel!
    @IBOutlet weak var proccessTextField: CPTextField!
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverNameTextField: CPTextField!
    
    @IBOutlet weak var receiverPhoneLabel: UILabel!
    @IBOutlet weak var receiverPhoneTextField: CPTextField!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextField: CPDescriptionTextField!
    
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
        plakLabel.apply(.blackS14R400)
        proccessLabel.apply(.blackS14R400)
        receiverNameLabel.apply(.blackS14R400)
        receiverPhoneLabel.apply(.blackS14R400)
        addFileLabel.apply(.blackS14R400)
        documentNameLabel.apply(.blackS14R400)
        selectFileLabel.apply(.blackS14R400)
        addressLabel.apply(.blackS14R400)
        setDashedBorder()
        setTextFieldsStyle()
    }
    
    func setTextFieldsStyle() {
        let array = [nameTextField, emailTextField, phoneTextField, plakTextField, proccessTextField, receiverNameTextField, receiverPhoneTextField]
        
        for item in array {
            item?.apply(.custom(.textFieldGreyText, .regular, 14))
            item?.contentView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        }
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
        
        plakLabel.text = Strings.yourLicensePlate
        plakTextField.placeholder = Strings.enterYourLicensePlate
        
        proccessLabel.text = Strings.processType
        proccessTextField.placeholder = Strings.enterProcessType
        
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
        nameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        plakTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        proccessTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        proccessTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        receiverNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        receiverPhoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        setButtonActivation()
    }
    
    func setButtonActivation() {
        let note = noteTextField.text.count > 0
        let address = addressTextField.text.count > 0
        let name = nameTextField.pureTextCount > 0
        let email = emailTextField.pureTextCount > 0
        let phone = phoneTextField.pureTextCount > 0
        let plak = plakTextField.pureTextCount > 0
        let proccess = proccessTextField.pureTextCount > 0
        let receiverName = receiverNameTextField.pureTextCount > 0
        let receiverPhone = receiverPhoneTextField.pureTextCount > 0
        
        let result = note && address && name && email && phone && plak && proccess && receiverName && receiverPhone
        createButton.isEnabled = result
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapCreate() {
        viewModel.createCase(licensePlate: plakTextField.text ?? "",
                             note: noteTextField.text,
                             nameSurname: nameTextField.text ?? "",
                             receiverPersonName: receiverNameTextField.text ?? "",
                             receiverPersonPhone: receiverPhoneTextField.text ?? "",
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
        picker.dismiss(animated: true)
        guard let data = tempImage.pngData() else { return }
        Loading.shared.show(presentingView: self.view)
        viewModel.sendFile(data: data)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ReqFlw3Stp3HGSViewController: ReqFlw3Stp3HGSViewModelDelegate {
    
}
