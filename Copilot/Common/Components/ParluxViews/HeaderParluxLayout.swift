//
//  HeaderParluxLayout.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import Foundation
import UIKit

class HeaderParluxLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        let offsetY = collectionView!.contentOffset.y
        let delta = abs(offsetY)
        
        for attr in layoutAttributes! {
            if let elementKind = attr.representedElementKind {
                if elementKind == UICollectionView.elementKindSectionHeader {
                    
                    var frame = attr.frame
                    if offsetY < 0 {
                        // resillient here
                        frame.size.height = max(0, frame.size.height + delta)
                        frame.origin.y = frame.minY - delta
                        attr.frame = frame
                    } else {
                        // parlux here
                        attr.zIndex = -1
                        frame.origin.y = frame.minY + delta // /1.5
                        
                    }
                    attr.frame = frame
                }
            } else if attr.indexPath.section == 0, attr.indexPath.item == 0 {
                var frame = attr.frame
                if offsetY > 84 {
                    print(offsetY)
                    attr.zIndex = 111
                    frame.origin.y = frame.minY + delta - 84
                    
                }
                attr.frame = frame
            }
            
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class ContentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var contentTitle: String {
        return "Content title"
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setRedBackground()
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerSupplementaryViewHeader(cellType: HeaderCell.self)
        collectionView.register(cellType: ContentCell.self)
        collectionView.contentInset.bottom = 70
        collectionView.backgroundColor = .clear
    }
    
    func applyStyle() {
        
    }
    
    func setTexts() {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: HeaderCell = collectionView.dequeueReusableSupplementaryView(for: indexPath, kind: UICollectionView.elementKindSectionHeader)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: ContentCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.title = contentTitle
            return cell
        }
        return cellFor(indexPath: indexPath)
    }
    
    func cellFor(indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.title = contentTitle
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 48, height: section == 0 ? 84: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
