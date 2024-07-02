//
//  NearMeViewController.swift
//  Copilot
//
//  Created by Jamal on 10/29/23.
//

import Foundation
import UIKit
import GoogleMaps

class NearMeViewController: UIViewController {
    
    var viewModel: NearMeViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet var iconViews: [UIView]!
    @IBOutlet weak var filterButtonView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    private lazy var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey(CodeStrings.GMSServiceAPIKey)
        setupUI()
        
#if DEV_DEBUG
//        viewModel.getSuppliers()
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
        setupMap()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backImageView.image = backImageView.image?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = .lightBlack
        titleLabel.apply(.blackS20B700)
        mapContainerView.layer.cornerRadius = 40
        mapContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        for view in iconViews {
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.theme.cgColor
            view.backgroundColor = .white
        }
        filterButtonView.layer.cornerRadius = 10
        filterLabel.apply(.whiteS12B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.homepage.near")
        filterLabel.text = App.getString(key: "copilotapp.homepage.near.button")
    }
    
    func setupMap() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.frame = view.frame
        mapView.delegate = self
        if let current = locationManager.location?.coordinate {
            mapView.camera = GMSCameraPosition.camera(withLatitude: current.latitude, longitude: current.longitude, zoom: 14)
        }
        mapContainerView.addSubview(mapView)
        mapContainerView.clipsToBounds = true
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
    }
    
    func showSuppliersOnMap() {
        guard let suppliers = viewModel.suppliers else { return }
        for data in suppliers {
            if let lat = data.latitude, let lon = data.longitude {
                let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let marker = GMSMarker()
                marker.position = location
                marker.snippet = data.name
                marker.title = data.name
                marker.map = mapView
                marker.appearAnimation = .fadeIn
            }
        }
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
    
    @IBAction func didTapFilter(_ sender: UIButton) {
        viewModel.presentFilters()
    }
    
    @IBAction func didTapLocation(_ sender: UIButton) {
        showUserLocation()
    }
}

extension NearMeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        viewModel.userLocation = location
        showUserLocation()
        locationManager.stopUpdatingLocation()
//        viewModel.getPlaces()
    }
    
    func showUserLocation() {
        let location = viewModel.userLocation
        let camera = GMSCameraPosition(target: location.coordinate, zoom: 14)
        mapView.animate(to: camera)
    }
}

extension NearMeViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        showActionSheet(lat: marker.position.latitude, lon: marker.position.longitude)
        return false
    }
    
    func showActionSheet(lat: Double, lon: Double) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let mapStr =  App.getString(key: "copilotapp.home.map") ?? ""
        let firstAction: UIAlertAction = UIAlertAction(title: mapStr, style: .default) { [weak self] _ in
            self?.viewModel.openAppleMap(latitude: lat, longitude: lon)
        }
        let googleStr = App.getString(key: "copilotapp.home.google.map") ?? ""
        let secondAction: UIAlertAction = UIAlertAction(title: googleStr, style: .default) { [weak self] _ in
            self?.viewModel.openGoogleMap(latitude: lat, longitude: lon)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: Strings.cancel, style: .cancel)
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
}

extension NearMeViewController: NearMeViewModelDelegate {
    func clearMap() {
        mapView.clear()
    }
}
