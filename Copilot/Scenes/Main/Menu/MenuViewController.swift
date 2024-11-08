//
//  MenuViewController.swift
//  Copilot
//
//  Created by Jamal on 10/12/23.
//

import Foundation
import UIKit

class MenuViewController: PopupViewController {
    
    var viewModel: MenuViewModelType! {
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
        navigationController?.navigationBar.isHidden = true
        
#if DEV_DEBUG
        //        viewModel.showDocuments()
        // viewModel.showRequests()
#endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabbarView()
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
        return viewModel.visibleItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MenuCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.chevronImageView.isHidden = indexPath.item != 0
        cell.imageView.image = viewModel.visibleItems[indexPath.item].image
        cell.titleLabel.text = viewModel.visibleItems[indexPath.item].title
        cell.imageView.tintColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 80, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let order = viewModel.visibleItems[indexPath.item].id
        switch order {
        case 0:
            viewModel.showProfile()
            
        case 1:
            viewModel.showCampaigns()
            
        case 2:
            viewModel.showDocuments()
            
        case 3:
            viewModel.showVehicleInfo()
            
        case 4:
            viewModel.showVehicleHGS()
            
        case 5:
            viewModel.showRequests()
            
        case 6:
            viewModel.showServices()
            
        case 7:
            viewModel.showSettings()
            
        case 8:
            viewModel.presentDeleteAccount()
            
        default:
            break
        }
        //        viewModel.hideMenu()
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
