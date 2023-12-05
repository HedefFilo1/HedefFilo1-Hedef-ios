//
//  HomeContentCell.swift
//  Copilot
//
//  Created by Jamal on 10/11/23.
//

import UIKit

protocol HomeContentCellDelegate: PointsCellDelegate {
    func didSelectNearMe()
}

class HomeContentCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: HomeContentCellDelegate?
    
    var appointment: Case? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var tire: Tire? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: RandevuCell.self)
        collectionView.register(cellType: NearMeCell.self)
        collectionView.register(cellType: TireInfoCell.self)
        collectionView.register(cellType: MaintainInfoCell.self)
        collectionView.register(cellType: PointsCell.self)
        collectionView.contentInset.top = 24
        collectionView.contentInset.bottom = 32
        applyStyles()
    }
    
    private func applyStyles() {
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 40
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}

extension HomeContentCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return appointment == nil ? 0: 1
        }
        
        if section == 2 {
            return tire == nil ? 0: 1
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: RandevuCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.appointment = appointment
            return cell
            
        case 1:
            let cell: NearMeCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 2:
            let cell: TireInfoCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.tire = tire
            return cell
            
        case 3:
            let cell: MaintainInfoCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 4:
            let cell: PointsCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = delegate
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 1 {
            delegate?.didSelectNearMe()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 116
            
        case 1:
            height = 200
            
        case 2:
            height = 104
            
        case 3:
            height = 112
            
        case 4:
            height = 146
            
        default:
            break
        }
        return CGSize(width: collectionView.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 3, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        32
    }
}
