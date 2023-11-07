//
//  NewsTabCell.swift
//  Copilot
//
//  Created by Jamal on 11/6/23.
//

import UIKit

class SponsorshipTabCell: UICollectionViewCell, Reusable {
    
    weak var delegate: CampaignsTabCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CampaignsTitleCell.self)
        collectionView.register(cellType: SponsorshipCell.self)
        collectionView.contentInset.bottom = 90
    }
}

extension SponsorshipTabCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1: 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: CampaignsTitleCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
        let cell: SponsorshipCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = delegate
        if indexPath.item == 1 {
            cell.isRightToLeft = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 48,
                      height: indexPath.section == 0 ? 84: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
