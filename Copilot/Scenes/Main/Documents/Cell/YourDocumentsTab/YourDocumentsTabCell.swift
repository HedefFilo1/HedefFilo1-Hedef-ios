//
//  YourDocumentsTabCell.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import UIKit

protocol YourDocumentsTabDelegate: DocumentCellDelegate {
    func didSelectDocumentItem(document: Document)
}

class YourDocumentsTabCell: UICollectionViewCell, Reusable {
    
    var items: [Document]? {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate: YourDocumentsTabDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: DocumentPageTitleCell.self)
        collectionView.register(cellType: DocumentCell.self)
        collectionView.contentInset.bottom = 90
    }
}

extension YourDocumentsTabCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 1 {
            return items?.count ?? 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: DocumentPageTitleCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
        let cell: DocumentCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = delegate
        cell.item = items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 54
            
        case 1:
            height = 60
            
        case 2:
            height = 50
            
        default:
            break
        }
        return CGSize(width: collectionView.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 16
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 2 {
            return UIEdgeInsets(top: 93, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1, let document = items?[indexPath.item] {
            delegate?.didSelectDocumentItem(document: document)
        }
    }
}
