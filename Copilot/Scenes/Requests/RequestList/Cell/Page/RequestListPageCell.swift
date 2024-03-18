//
//  RequestListPageCell.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import UIKit

protocol RequestListPageCellDelegate: AnyObject {
    func didSelect(item: String)
}

class RequestListPageCell: UICollectionViewCell, Reusable {
    
    var items: [Campaign]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: RequestListPageCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        label.apply(.blackS14R400)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: RequestListItemCell.self)
        collectionView.contentInset.bottom = 90
        label.text = Strings.requestsQuestionDescription
    }
}

extension RequestListPageCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: RequestListItemCell = collectionView.dequeueReusableCell(for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(item: "Title")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 48, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
