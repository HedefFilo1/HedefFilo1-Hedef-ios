//
//  ServicesItemsCell.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import UIKit

protocol PastServicesItemsCellDelegate: AnyObject {
    func didSelect(item: PastService)
}

class PastServicesItemsCell: UICollectionViewCell, Reusable {
    
    var foundMessage = Strings.pastMaintenanceFound
    var items: [PastService]? {
        didSet {
            let count = items?.count ?? 0
            let text = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.found")?.replacingOccurrences(of: "{number}", with: "") ?? ""
            titleLabel.text = "\(count) \(text)"
            collectionView.reloadData()
        }
    }
    weak var delegate: PastServicesItemsCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: PastServicesItemCell.self)
        collectionView.contentInset.top = 12
        collectionView.contentInset.bottom = 24
        backgroundColor = .white
        applyStyles()
    }
    
    private func applyStyles() {
        titleLabel.apply(.greyS12R400)
    }
    
}

extension PastServicesItemsCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PastServicesItemCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.dateLabel.text = "\(indexPath.item)"
        cell.item = items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = items?[indexPath.item] {
            delegate?.didSelect(item: item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 151)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
