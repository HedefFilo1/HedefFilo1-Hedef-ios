//
//  ReqFlw6Stp3InspectionViewController.swift
//  Copilot
//
//  Created by Jamal on 3/8/24.
//

import Foundation
import UIKit
import MobileCoreServices

class ReqFlw6Stp3InspectionViewController: UIViewController {
    
    var viewModel: ReqFlw6Stp3InspectionViewModelType! {
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
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverNameTextField: CPTextField!
    
    @IBOutlet weak var receiverIdLabel: UILabel!
    @IBOutlet weak var receiverIdTextField: CPTextField!
    
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
        receiverNameLabel.apply(.blackS14R400)
        receiverIdLabel.apply(.blackS14R400)
        addFileLabel.apply(.blackS14R400)
        documentNameLabel.apply(.blackS14R400)
        selectFileLabel.apply(.blackS14R400)
        setDashedBorder()
        setTextFieldsStyle()
    }
    
    func setTextFieldsStyle() {
        let array = [nameTextField, emailTextField, phoneTextField, plateTextField, receiverNameTextField, receiverIdTextField]
        
        for item in array {
            item?.apply(.custom(.textFieldGreyText, .regular, 14))
            item?.contentView.backgroundColor = .greyBorder.withAlphaComponent(0.4)
        }
    }
    
    func setTexts() {
        titleLabel.text = Strings.inspectionOperations
        
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
        
        receiverNameLabel.text = Strings.nameSurnamePersonVehicle
        receiverNameTextField.placeholder = Strings.enterNameSurnamePersonVehicle
        
        receiverIdLabel.text = Strings.idNumberPersonVehicle
        receiverIdTextField.placeholder = Strings.enterIdNumberPersonVehicle
        
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
        
        receiverNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        receiverIdTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        setButtonActivation()
    }
    
    func setButtonActivation() {
        let note = noteTextField.text.count > 0
        let name = nameTextField.pureTextCount > 0
        let email = emailTextField.pureTextCount > 0
        let phone = phoneTextField.pureTextCount > 0
        let plate = plateTextField.pureTextCount > 0
        let receiverName = receiverNameTextField.pureTextCount > 0
        let receiverId = receiverIdTextField.pureTextCount > 0
        
        let result = note && name && email && phone && plate && receiverName && receiverId
        createButton.isEnabled = result
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapSendFile() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
}

extension ReqFlw6Stp3InspectionViewController: CPDescriptionTextFieldDelegate {
    func didEditingChanged() {
        setButtonActivation()
    }
}

extension ReqFlw6Stp3InspectionViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        guard let data = try? Data(contentsOf: selectedFileURL) else { return }
        viewModel.sendFile(data: data)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // User cancelled the document picker
    }
    
}

extension ReqFlw6Stp3InspectionViewController: ReqFlw6Stp3InspectionViewModelDelegate {
    
}
