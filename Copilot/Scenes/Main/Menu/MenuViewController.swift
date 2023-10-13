//
//  MenuViewController.swift
//  Copilot
//
//  Created by Jamal on 10/12/23.
//

import Foundation
import UIKit

class MenuViewController: PopupViewController {
    
    // MARK: - Properties
    var viewModel: MenuViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        RightToLeftPresentation(presentedViewController: presented, presenting: presenting)
    }
    
    private func setupUI() {
        setupCollectionView()
        applyStyles()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: MenuCell.self)
        collectionView.contentInset.top = 24
    }
    
    private func applyStyles() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MenuCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.chevronImageView.isHidden = indexPath.item != 0
        switch indexPath.item {
        case 0:
            cell.imageView.image = Images.personIcon
            cell.titleLabel.text = Strings.profile
            
        case 1:
            cell.imageView.image = Images.percentIcon
            cell.titleLabel.text = Strings.campaigns
            
        case 2:
            cell.imageView.image = Images.documentIcon
            cell.titleLabel.text = Strings.documents
            
        case 3:
            cell.imageView.image = Images.carIcon
            cell.titleLabel.text = Strings.vehicleInformation
            
        case 4:
            cell.imageView.image = Images.carIcon
            cell.titleLabel.text = Strings.vehicleHGSPasses
            
        case 5:
            cell.imageView.image = Images.listIcon
            cell.titleLabel.text = Strings.myDemands
            
        case 6:
            cell.imageView.image = Images.toolIcon
            cell.titleLabel.text = Strings.services
            
        case 7:
            cell.imageView.image = Images.settingsIcon
            cell.titleLabel.text = Strings.settings
            
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            viewModel.showProfile()
        }
        viewModel.hideMenu()
    }
}

extension MenuViewController {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return RightToLeftTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LeftToRightTransition()
    }
}

extension MenuViewController: MenuViewModelDelegate {
    
}
