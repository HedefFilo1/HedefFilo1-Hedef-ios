//
//  ServicesViewController.swift
//  Copilot
//
//  Created by Jamal on 12/26/23.
//

import Foundation
import UIKit
import CoreLocation

class ServicesViewController: UIViewController {
    
    var viewModel: ServicesViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var filtering = false
    private var searchText = ""
    private let locationManager = CLLocationManager()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
#if DEV_DEBUG
        if let coordintor = viewModel.coordinatorDelegate as? ServicesCoordinator {
            //            coordintor.goToServiceDetail(service: Supplier(id: "e3", name: "Boch SErvice", address: "Marawa", lon: "", lat: ""))
            //            class Fss:  CalendarViewControllerDelegate {
            //                func didSelect(date: Date) {
            //
            //                }
            //            }
            //            coordintor.presentCalendar(delegate: Fss())
        }
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ServicesSearchCell.self)
        collectionView.register(cellType: ServicesItemsCell.self)
        collectionView.contentInset.bottom = 12
        collectionView.contentInset.bottom = 70
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.services
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: ServicesSearchCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
        }
        
        let cell: ServicesItemsCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.items = viewModel.filteredServices
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 74)
        } else {
            
            let count = viewModel.services?.count ?? 0
            let height = CGFloat(count * 102 + (count * 8)) - 8 + 44
            return CGSize(width: collectionView.frame.width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension ServicesViewController: ServicesSearchCellDelegate {
    func didChangeSearch(text: String) {
        searchText = text
        if filtering {
            return
        }
        filtering = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) {
            self.viewModel.searchText = self.searchText
            self.collectionView.reloadSections(IndexSet(integer: 1))
            self.filtering = false
        }
        
    }
    
    func didTapFilter() {
        viewModel.presentFilters()
    }
}

extension ServicesViewController: ServicesItemsCellDelegate {
    func didSelect(item: Supplier) {
        viewModel.goToServiceDetail(service: item)
    }
}

extension ServicesViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .notDetermined ||
            manager.authorizationStatus == .restricted ||
            manager.authorizationStatus == .restricted {
            viewModel.getServices(lat: nil, lon: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        viewModel.getServices(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
    }
}

extension ServicesViewController: ServicesViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
