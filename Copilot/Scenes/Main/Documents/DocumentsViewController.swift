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
    @IBOutlet weak var yourDocsButton: UIButton!
    @IBOutlet weak var neccessaryButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var borderViews: [UIView]!
    
    private var selectedNecessaryItem: NecessaryDocument?
    private var currentTab = 0
    
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
        setBasicViews()
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: YourDocumentsTabCell.self)
        collectionView.register(cellType: NecessaryDocumentsTabCell.self)
        collectionView.register(cellType: DocumentsTabCell.self)
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        
        yourDocsButton.apply(.blackS18R400)
        neccessaryButton.apply(.blackS18R400)
        for view in borderViews {
            view.backgroundColor = .disabled
        }
        borderViews[0].backgroundColor = .theme
    }
    
    func setTexts() {
        titleLabel.text = Strings.yourDocuments
        yourDocsButton.setTitle(Strings.yourDocuments, for: .normal)
        neccessaryButton.setTitle(Strings.necessaryDocuments, for: .normal)
    }
    
    @IBAction func didTab(_ sender: UIView) {
        let tag = sender.tag
        if tag == currentTab {
            return
        }
        borderViews[currentTab].backgroundColor = .disabled
        currentTab = tag
        borderViews[tag].backgroundColor = .theme
        collectionView.scrollToItem(at: IndexPath(row: 0, section: tag), at: .centeredHorizontally, animated: true)
    }
}

extension DocumentsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: YourDocumentsTabCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.items = viewModel.documents
            cell.delegate = self
            return cell
            
        case 1:
            let cell: NecessaryDocumentsTabCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.items = viewModel.neccessarItems
            cell.delegate = self
            return cell
            
        case 2:
            let cell: DocumentsTabCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.items = viewModel.necessaryDocuments
            cell.selectedNecessaryItem = selectedNecessaryItem
            cell.delegate = self
            return cell
            
        default:
            let cell: DocumentsTabCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
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
        viewModel.goToDocument()
    }
}

extension DocumentsViewController: YourDocumentsTabDelegate {
    func didSelectDocumentItem() {
        viewModel.goToDocument()
    }
    
    func didTapDelete(item: Document) {
        viewModel.delete(document: item)
        collectionView.reloadData()
    }
    
    func didTapDownload() {
        
    }
    
    func didTapUpload() {
//        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.item], asCopy: false)
//        documentPicker.modalPresentationStyle = .formSheet
//        present(documentPicker, animated: true, completion: nil)
    }
}

extension DocumentsViewController: NecessaryDocumentsTabDelegate {
    func didSelectNeccessary(item: NecessaryDocument) {
        selectedNecessaryItem = item
        collectionView.reloadSections(IndexSet(integer: 2))
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 2), at: .centeredHorizontally, animated: true)
    }
}

extension DocumentsViewController: DocumentsTabDelegate {
    func didTabBack() {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .centeredHorizontally, animated: true)
    }
}

extension DocumentsViewController: DocumentsViewModelDelegate {
    
}
