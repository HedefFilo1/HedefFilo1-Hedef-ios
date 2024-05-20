//
//  RequestListPageCell.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import UIKit

protocol RequestListPageCellDelegate: AnyObject {
    func didSelect(item: Task)
}

class RequestListPageCell: UICollectionViewCell, Reusable {
    
    var items: [Task]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var requestItems: [Demand]? {
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
        label.text = App.getString(key: "copilotapp.demandlist.product.tab.description")
    }
}

extension RequestListPageCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items {
            return items.count
        }
        return requestItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: RequestListItemCell = collectionView.dequeueReusableCell(for: indexPath)
        if let items = items {
            cell.item = items[indexPath.item]
        } else {
            cell.request = requestItems?[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = items?[indexPath.item] {
            delegate?.didSelect(item: item)
        }
        
        if let item = requestItems?[indexPath.item] {
            let type = item.status
            let status = TaskStatus(rawValue: type) ?? .other
            let task = Task(id: item.id ?? "",
                            subject: item.recordType ?? "",
                            additionalInfo: item.webCategoryEnum ?? "",
                            description: "",
                            statusText: item.status,
                            status: status)
            delegate?.didSelect(item: task)
        }
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
