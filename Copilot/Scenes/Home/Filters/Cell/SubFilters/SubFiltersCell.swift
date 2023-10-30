//
//  SubFiltersCell.swift
//  Copilot
//
//  Created by Jamal on 10/30/23.
//

import UIKit

class SubFiltersCell: UICollectionViewCell, Reusable {
    
    var item: Filter? {
        didSet {
            titleLabel.text = item?.tilte
        }
    }
    
    var items: [Filter]?

    @IBOutlet weak var checkBox: CPCheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: FilterCell.self)
        applyStyles()
    }
    
    private func applyStyles() {
        chevronImageView.image = chevronImageView.image?.withRenderingMode(.alwaysTemplate)
        chevronImageView.tintColor = .fieldDescription
        chevronImageView.transform = CGAffineTransform(rotationAngle: 2 * .pi)
        titleLabel.apply(.blackS16R400)
    }
    
    func toggle() {
        let opened = item?.showSubFilters ?? false
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.chevronImageView.transform = CGAffineTransform(rotationAngle: opened ? -CGFloat.pi: 2 * .pi)
            self.chevronImageView.tintColor = opened ? .black: .fieldDescription
            self.layoutIfNeeded()
        }
    }
}

extension SubFiltersCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.item = items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let filter = items?[indexPath.item],
           let cell = collectionView.cellForItem(at: indexPath) as? FilterCell {
            filter.selected = !filter.selected
            cell.checkBox.isSelected = filter.selected
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

