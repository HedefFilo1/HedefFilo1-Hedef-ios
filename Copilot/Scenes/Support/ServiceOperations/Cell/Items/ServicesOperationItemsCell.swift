//
//  ServicesItemsCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

protocol ServicesOperationItemsCellDelegate: AnyObject {
    func didSelect(item: Supplier)
}

class ServicesOperationItemsCell: UICollectionViewCell, Reusable {
    
    var items: [Supplier]? {
        didSet {
            let count = items?.count ?? 0
            titleLabel.text = "\(count) \(Strings.servicesFound)"
            collectionView.reloadData()
        }
    }
    weak var delegate: ServicesOperationItemsCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ServicesOperationItemCell.self)
        collectionView.contentInset.top = 12
        collectionView.contentInset.bottom = 24
        backgroundColor = .white
        applyStyles()
    }
    
    private func applyStyles() {
        titleLabel.apply(.greyS12R400)
    }
    
}

extension ServicesOperationItemsCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ServicesOperationItemCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.item = items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = items?[indexPath.item] {
            delegate?.didSelect(item: item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 77)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
}
