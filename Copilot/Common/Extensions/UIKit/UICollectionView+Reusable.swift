//
//  UICollectionView+Reusable.swift
//  PayCore
//
//  Created by Fikri Can Cankurtaran on 21.07.2022.
//

import UIKit

extension UICollectionView {
    public final func register<T: UICollectionViewCell>(cellType: T.Type)
    where T: Reusable {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    public final func registerSupplementaryView<T: UICollectionViewCell>(cellType: T.Type)
    where T: Reusable {
        register(cellType.nib,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: cellType.reuseIdentifier)
    }

    public final func registerSupplementaryViewHeader<T: UICollectionReusableView>(
        cellType: T.Type) where T: Reusable {
        register(cellType.nib,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: cellType.reuseIdentifier)
    }

    public final func registerSupplementaryViewFooter<T: UICollectionReusableView>(
        cellType: T.Type) where T: Reusable {
        register(cellType.nib,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: cellType.reuseIdentifier)
    }

    public final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath,
                                                                   cellType: T.Type = T.self) -> T
    where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }

    public final func dequeueReusableSupplementaryView<T: UICollectionViewCell>(
        for indexPath: IndexPath, kind: String, cellType: T.Type = T.self) -> T
    where T: Reusable {
        guard let cell = dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: cellType.reuseIdentifier,
                for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }

    public final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        for indexPath: IndexPath, kind: String, cellType: T.Type = T.self) -> T
    where T: Reusable {
        guard let cell = dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
}
