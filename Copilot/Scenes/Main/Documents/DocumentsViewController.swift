//
//  DocumentsViewController.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import Foundation
import UIKit

class DocumentsViewController: UIViewController {
    
    var viewModel: DocumentsViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var uploadButton: CPLightButton!
    
    private var selectedIndex: Int?
    
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
        setBasicViews(addNotfication: false, addSearch: false)
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: DocumentCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 24, bottom: 12, right: 24)
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.greyS14R400)
        uploadLabel.apply(.themeS16B700)
        uploadImageView.image = uploadImageView.image?.withRenderingMode(.alwaysTemplate)
        uploadImageView.tintColor = .theme
        uploadButton.backgroundColor = .clear
    }
    
    func setTexts() {
        titleLabel.text = Strings.yourDocuments
        descriptionLabel.text = Strings.documentsSavedInCopilot
        uploadLabel.text = Strings.uploadDocument
    }

    @IBAction func didTapUpload() {
        
    }
    
}

extension DocumentsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: DocumentCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        cell.item = viewModel.documents?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 48, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension DocumentsViewController: DocumentCellDelegate {
    func didTapDelete() {
        
    }
    
    func didTapDownload() {
        
    }
}

extension DocumentsViewController: DocumentsViewModelDelegate {
    
}
