//
//  DocumentsTabCell.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import UIKit

protocol DocumentsTabDelegate: DocumentsTabTitleCellDelegate, DocumentCellDelegate {
    func didSelectDocumentItem()
}

class DocumentsTabCell: UICollectionViewCell, Reusable {
    
    var items: [Document]?
    var selectedNecessaryItem: NecessaryDocument? {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate: DocumentsTabDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: DocumentsTabTitleCell.self)
        collectionView.register(cellType: DocumentCell.self)
        collectionView.contentInset.bottom = 90
    }
}

extension DocumentsTabCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: DocumentsTabTitleCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = selectedNecessaryItem?.title
            cell.delegate = delegate
            return cell
        }
        
        let cell: DocumentCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = delegate
        cell.item = items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 48, height: indexPath.section == 0 ? 54: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            delegate?.didTabBack()
//            return
//        }
        if indexPath.section == 1 {
            delegate?.didSelectDocumentItem()
        }
    }
}
