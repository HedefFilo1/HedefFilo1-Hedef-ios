//
//  NecessaryDocumentsTabCell.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import UIKit

protocol NecessaryDocumentsTabDelegate: AnyObject {
    func didSelectNeccessary(item: NecessaryDocument)
}

class NecessaryDocumentsTabCell: UICollectionViewCell, Reusable {
    
    var items: [NecessaryDocument]?
    weak var delegate: NecessaryDocumentsTabDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: DocumentPageTitleCell.self)
        collectionView.register(cellType: NecessaryItemCell.self)
        collectionView.contentInset.bottom = 90
    }
}

extension NecessaryDocumentsTabCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            let cell: DocumentPageTitleCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
        let cell: NecessaryItemCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.topLine.isHidden = indexPath.item != 0
        let count = items?.count ?? 0
        cell.bottomLine.isHidden = indexPath.item == count - 1
        cell.titleLabel.text = items?[indexPath.item].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 48, height: indexPath.section == 0 ? 54: 56 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = items?[indexPath.item] {
            delegate?.didSelectNeccessary(item: item)
        }
    }
}
