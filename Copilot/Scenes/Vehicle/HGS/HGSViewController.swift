//
//  HGSViewController.swift
//  Copilot
//
//  Created by Jamal on 11/24/23.
//

import Foundation
import UIKit

class HGSViewController: UIViewController {
    
    var viewModel: HGSViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getTransitions()
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: HGSEmptyCell.self)
        collectionView.register(cellType: HGSCell.self)
        collectionView.contentInset.bottom = 70
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.vehicleHGSPasses
    }
    
}

extension HGSViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.transitons?.count ?? 0
        if section == 0 {
            return (count == 0 && viewModel.transitons != nil) ? 1: 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: HGSEmptyCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
        let cell: HGSCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.item = viewModel.transitons?[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 48, height: indexPath.section == 0 ? 150: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension HGSViewController: HGSCellDelegate {
    func didTapDetail(transition: Transition) {
        viewModel.goToHGSDetail(transition: transition)
    }
}

extension HGSViewController: HGSViewModelDelegate {
    func showError(title: String, message: String, delegate: MessagePopupViewControllerDelegate?) {
        showError(errorTitle: title, message: message, delegate: self)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension HGSViewController: MessagePopupViewControllerDelegate {
    func didDismiss(_: SuccessPopupViewController?) {
        select(tab: 4)
    }
}
