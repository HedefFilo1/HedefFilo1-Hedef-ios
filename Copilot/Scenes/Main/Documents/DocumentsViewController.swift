//
//  DocumentsViewController.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import Foundation
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class DocumentsViewController: UIViewController {
    
    var viewModel: DocumentsViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getDocuments()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: YourDocumentsTabCell.self)
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.yourDocuments
    }
}

extension DocumentsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YourDocumentsTabCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.items = viewModel.documents
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension DocumentsViewController: YourDocumentsTabDelegate {
    func didSelectDocumentItem(document: Document) {
        viewModel.goToDocument(document: document)
    }
    
    func didTapDelete(item: Document) {
        viewModel.presentDocumentPopup(document: item)
    }
    
    func didTapDownload() {
        
    }
    
    func didTapUpload() {
        //        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.item], asCopy: false)
        //        documentPicker.modalPresentationStyle = .formSheet
        //        present(documentPicker, animated: true, completion: nil)
    }
}

extension DocumentsViewController: DocumentsViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
