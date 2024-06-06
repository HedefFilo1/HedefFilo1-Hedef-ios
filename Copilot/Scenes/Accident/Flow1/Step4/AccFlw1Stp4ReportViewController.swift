//
//  AccFlw1Stp4ReportViewController.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import UIKit
import PDFKit

class AccFlw1Stp4ReportViewController: UIViewController {
    
    var viewModel: AccFlw1Stp4ReportViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var button: CPButton!
    
    private var selectedFiles: [UIImage?] = [
        nil, nil, nil, nil, nil
    ]
    
    private var currentIndex = 1
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
#if DEV_DEBUG
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: AccFlw1Stp4ReportHeaderCell.self)
        collectionView.register(cellType: AccFlw1Stp4ReportTitleCell.self)
        collectionView.register(cellType: AccFlw1Stp4ReportImageCell.self)
        collectionView.register(cellType: UploadPhotoCell.self)
        collectionView.contentInset.bottom = 20
        button.isEnabled = true
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setTexts() {
        //        let text = "\(Strings.devamEt) (1 \(Strings.photoSelected))"
        button.setTitle(Strings.devamEt, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapContinue() {
        viewModel.goToAccFlw1Stp5Leaks()
    }
    
}

extension AccFlw1Stp4ReportViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section != 0 {
            return 2
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: AccFlw1Stp4ReportHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
            
        case 1:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.minute")
                cell.buttonView.isHidden = false
                cell.delegate = self
                return cell
            }
            
            if let image = selectedFiles[0] {
                let cell: AccFlw1Stp4ReportImageCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.imageView.image = image
                cell.delegate = self
                cell.index = 0
                return cell
            } else {
                let cell: UploadPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
            
        case 2:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.other.driver.license")
                cell.buttonView.isHidden = true
                return cell
            }
            
            if let image = selectedFiles[1] {
                let cell: AccFlw1Stp4ReportImageCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.imageView.image = image
                cell.delegate = self
                cell.index = 1
                return cell
            } else {
                let cell: UploadPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
            
        case 3:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.other.insurance.policy.other")
                cell.buttonView.isHidden = true
                return cell
            }
            
            if let image = selectedFiles[2] {
                let cell: AccFlw1Stp4ReportImageCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.imageView.image = image
                cell.delegate = self
                cell.index = 2
                return cell
            } else {
                let cell: UploadPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
            
        case 4:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.license.other")
                cell.buttonView.isHidden = true
                return cell
            }
            
            if let image = selectedFiles[3] {
                let cell: AccFlw1Stp4ReportImageCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.imageView.image = image
                cell.delegate = self
                cell.index = 3
                return cell
            } else {
                let cell: UploadPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
            
        case 5:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.photo.vehicle")
                cell.buttonView.isHidden = true
                return cell
            }
            
            if let image = selectedFiles[4] {
                let cell: AccFlw1Stp4ReportImageCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.imageView.image = image
                cell.delegate = self
                cell.index = 4
                return cell
            } else {
                let cell: UploadPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
            
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 353
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width-32, height: 191)
        }
        
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width-32, height: 27)
        }
        
        if selectedFiles[indexPath.section - 1] != nil {
            height = 120
        } else {
            height = 37
        }
        
        return CGSize(width: collectionView.frame.width-32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? UploadPhotoCell {
            currentIndex = indexPath.section - 1
            didTapSendFile()
        }
    }
}

extension AccFlw1Stp4ReportViewController: AccFlw1Stp4ReportHeaderCellDelegate {
    func didTapGuilde() {
        APIService.addUserAction(pageName: "Damage", actionName: "DAMAGE_GO_ACCIDENT_GUIDE")
        viewModel.goToGuide()
    }
}

extension AccFlw1Stp4ReportViewController: UINavigationControllerDelegate,
                                           UIImagePickerControllerDelegate,
                                           AccFlw1Stp4ReportImageCellDelegate {
    
    func didTapDelete(index: Int) {
        selectedFiles[index] = nil
        collectionView.reloadData()
    }
    
    func didTapSendFile() {
        //        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        //        documentPicker.delegate = self
        //        present(documentPicker, animated: true, completion: nil)
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        selectedFiles[currentIndex] = tempImage
        collectionView.reloadData()
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            //            fileNameLabel.text = url.lastPathComponent
            //            showFileNameView()
            //                fileType = url.pathExtension
        }
        picker.dismiss(animated: true)
        //        guard let data = tempImage.pngData() else { return }
        
        //        viewModel.sendFile(data: data)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AccFlw1Stp4ReportViewController: AccFlw1Stp4ReportTitleCellDelegate {
    func didTabSampleButton() {
        //        if let urlDestination = URL(string: CodeStrings.samplePdfUrl) {
        //            UIApplication.shared.open(urlDestination)
        //        }
        
        viewModel.showReportPdf()
//        if let urlDestination = URL(string: CodeStrings.samplePdfUrl) {
//            let viewController = pdf()
//            
//            // the url can be a web url or a file url
//            viewController.pdfURL = urlDestination
//            
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
    }
}

extension AccFlw1Stp4ReportViewController: AccFlw1Stp4ReportViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
