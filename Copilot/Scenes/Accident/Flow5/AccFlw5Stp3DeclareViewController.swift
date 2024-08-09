//
//  AccFlw5Stp3DeclareViewController.swift
//  Copilot
//
//  Created by Jamal on 2/23/24.
//

import Foundation
import UIKit

class AccFlw5Stp3DeclareVController: UIViewController {
    
    var viewModel: AccFlw5Stp3DeclareViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    private var selectedFiles = [UIImage]()
    
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
        collectionView.register(cellType: AccFlw5Stp3HeaderCell.self)
        collectionView.register(cellType: AccFlw5Stp3ContentCell.self)
        collectionView.register(cellType: ReportImageCell.self)
        collectionView.register(cellType: AccFlw5Stp3ButtonsCell.self)
        collectionView.contentInset.top = 34
        collectionView.contentInset.bottom = 20
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
        
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension AccFlw5Stp3DeclareVController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return selectedFiles.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: AccFlw5Stp3HeaderCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
            
        case 1:
            let cell: AccFlw5Stp3ContentCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 2:
            let cell: ReportImageCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.imageView.image = selectedFiles[indexPath.item]
            cell.index = indexPath.item
            cell.delegate = self
          return cell
            
        case 3:
            let cell: AccFlw5Stp3ButtonsCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            let moreText =  App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.upload.more.photo.button") ?? ""
            cell.uploadLabel.text = selectedFiles.count > 0 ? moreText: App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.upload.photo.button")
            return cell
        
        default:
            return UICollectionViewCell()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        
        switch indexPath.section {
        case 0:
         height = 180
            
        case 1:
         height = 200
            
        case 2:
            return CGSize(width: 104, height: 104)
            
        default:
            height = 176 + 90
        }
        
        return CGSize(width: collectionView.frame.width-32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 2 {
            return UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension AccFlw5Stp3DeclareVController: AccFlw5Stp3HeaderCellDelegate,
                                         AccFlw5Stp3ButtonsCellDelegate {
   
    func didTapGuilde() {
        APIService.addUserAction(pageName: "Damage", actionName: "DAMAGE_GO_ACCIDENT_GUIDE")
        
//        if let url = URL.init(string: "https://copilotweb.hedeffilotest.com/file-server/0cc1d38d-9e54-4ba1-908b-14bd8b59413f.pdf") {
//            UIApplication.shared.open(url)
//        }
        viewModel.showExamplePdf()
        //        viewModel.goToGuide()
    }
    
    func didTapUpload() {
        didTapSendFile()
    }
    
    func didTapContinue() {
        viewModel.goToAccFlow5Step4()
    }
}

extension AccFlw5Stp3DeclareVController: UINavigationControllerDelegate,
                                         UIImagePickerControllerDelegate,
                                         ReportImageCellDelegate {
    
    func didTapDelete(at index: Int) {
        selectedFiles.remove(at: index)
        collectionView.reloadData()
    }
    func didTapSendFile() {
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
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        selectedFiles.append(tempImage)
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

extension AccFlw5Stp3DeclareVController: AccFlw5Stp3DeclareViewModelDelegate {
    
}
