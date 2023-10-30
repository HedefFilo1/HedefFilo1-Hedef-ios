//
//  NearMeViewController.swift
//  Copilot
//
//  Created by Jamal on 10/29/23.
//

import Foundation
import UIKit
import MapKit

class NearMeViewController: UIViewController {
    
    var viewModel: NearMeViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var iconViews: [UIView]!
    @IBOutlet weak var filterButtonView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
#if DEV_DEBUG
        // just for test
//        viewModel.goToMain()
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
        setMap()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backImageView.image = backImageView.image?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = .lightBlack
        titleLabel.apply(.blackS20B700)
        mapView.layer.cornerRadius = 40
        mapView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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
        titleLabel.text = Strings.nearMe
        filterLabel.text = Strings.filters
    }
    
    func setMap() {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.95123211862574, longitude: 29.291049396735445), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
         mapView.setRegion(region, animated: true)
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
    
    @IBAction func didTapFilter(_ sender: UIButton) {
        viewModel.presentFilters()
    }
    
    @IBAction func didTapLocation(_ sender: UIButton) {
        
    }
}

extension NearMeViewController: NearMeViewModelDelegate {
    
}
