//
//  HomeViewController.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var logoutIcon: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
#if DEV_DEBUG

//        viewModel.coordinatorDelegate?.goToStandings()
//        viewModel.goToSearch()
        return
//        return
#endif
        viewModel.getVehicle(shoudGetCase: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
#if DEV_DEBUG
//        viewModel.goToStandings()
        return
        
        #endif
        viewModel.getVehicle(shoudGetCase: true)
    }
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        setupCollectionView()
        applyStyles()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: SearchCell.self)
        collectionView.register(cellType: VehicleInfoCell.self)
        collectionView.register(cellType: HomeContentCell.self)
        collectionView.contentInset.top = 12
        collectionView.contentInset.bottom = 57
    }
    
    private func applyStyles() {
        view.backgroundColor = .secondRed
        logoutIcon.image = logoutIcon.image?.withRenderingMode(.alwaysTemplate)
        logoutIcon.tintColor = .white
    }
    
    @IBAction func didTapNotificationButton() {
        APIService.addUserAction(pageName: "HOMEPAGE", actionName: "HOMEPAGE_NOTIFICATION")
        goToNotifications()
    }
    
    @IBAction func didTapLogoutButton() {
        App.appCoordinator?.logout()
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell: SearchCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 1:
            let cell: VehicleInfoCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.vehicle = viewModel.vehicle
            return cell
            
        case 2:
            let cell: HomeContentCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.appointment = viewModel.appointment
            cell.tire = viewModel.tire
            cell.last = viewModel.last
            cell.totalPoints = viewModel.totalPoints
            cell.barPoints = viewModel.barPoints
            return cell
        
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        var width: CGFloat = collectionView.frame.width
        
        switch indexPath.item {
        case 0:
            width -= 48
            height = 56
            
        case 1:
            width -= 48
            height = 205
            
        case 2:
            height = 684 + 140 + 20
            
            if viewModel.appointment == nil {
                height -= 116 + 32
            }
            
            if viewModel.tire == nil {
                height -= 104 + 32
            }
            
            if viewModel.last == nil {
                height -= 112 + 32
            }
            
        default:
            break
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            viewModel.goToSearch()
        }
    }
}

extension HomeViewController: VehicleInfoCellDelegate {
    func didTapKmUsed() {
        APIService.addUserAction(pageName: "HOMEPAGE", actionName: "HOMEPAGE_MAKE_CHANGE_CLICK")
        viewModel.presentKMUsed(delegate: self)
    }
}

extension HomeViewController: HomeContentCellDelegate {
    
    func seeAllPoints() {
        viewModel.goToStandings()
    }
    
    func didSelectNearMe() {
        viewModel.goToNearMe()
    }
}

extension HomeViewController: KMUsedViewControllerDelegate {
    func reloadDistance() {
        viewModel.getVehicle(shoudGetCase: false)
    }
}

extension HomeViewController: HomeViewModelViewDelegate {
    
    func setVehicle() {
        collectionView.reloadData()
    }
    
    func setAppointment() {
        collectionView.reloadData()
    }
    
    func setTire() {
        collectionView.reloadData()
    }
    
    func setLastMaintenance() {
        collectionView.reloadData()
    }
    
    func setTotalPoints() {
        collectionView.reloadData()
    }
    
    func setBarPoints() {
        collectionView.reloadData()
    }
}
