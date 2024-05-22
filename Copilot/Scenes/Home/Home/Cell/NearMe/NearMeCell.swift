//
//  NearMeCell.swift
//  Copilot
//
//  Created by Jamal on 10/11/23.
//

import UIKit
import MapKit

class NearMeCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var iconViews: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
        setMap()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS20B700)
        mapView.layer.cornerRadius = 15
        for view in iconViews {
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.theme.cgColor
            view.backgroundColor = .white
        }
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.gamification.near")
    }
    
    func setMap() {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.95123211862574, longitude: 29.291049396735445), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
         mapView.setRegion(region, animated: true)
    }
}
