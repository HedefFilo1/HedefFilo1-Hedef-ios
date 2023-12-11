//
//  VehicleGuideViewController.swift
//  Copilot
//
//  Created by Jamal on 11/24/23.
//

import Foundation
import UIKit

class VehicleGuideViewController: UIViewController {
    
    var viewModel: VehicleGuideViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
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
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: VehicleGuideCell.self)
        collectionView.register(cellType: VehicleCell.self)
        collectionView.register(cellType: VehicleDescriptionCell.self)
        collectionView.contentInset.bottom = 70
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.vehicleGuide
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension VehicleGuideViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: VehicleGuideCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 1:
            let cell: VehicleCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.vehicle = App.vehicle
            return cell
            
        case 2:
            let cell: VehicleDescriptionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 46
            
        case 1:
            height = 310
            
        case 2:
            height = 1310
            
        default:
            break
        }
        return CGSize(width: collectionView.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension VehicleGuideViewController: VehicleGuideViewModelDelegate {
    
}
