//
//  PastMaintenancesViewController.swift
//  Copilot
//
//  Created by Jamal on 3/28/24.
//

import Foundation
import UIKit

class PastMaintenancesViewController: UIViewController {
    
    var viewModel: PastMaintenancesViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maintenanceButton: UIButton!
    @IBOutlet var borderViews: [UIView]!
    @IBOutlet weak var breakdownButton: UIButton!
    @IBOutlet weak var tireButton: UIButton!
    @IBOutlet weak var accidentButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getServices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: PastServicesHeaderCell.self)
        collectionView.register(cellType: PastServicesSearchCell.self)
        collectionView.register(cellType: PastServicesItemsCell.self)
        collectionView.contentInset.top = 24
        collectionView.contentInset.bottom = 70
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS24R400)
        maintenanceButton.apply(.blackS18R400)
        maintenanceButton.setTitleColor(.theme, for: .normal)
        breakdownButton.apply(.blackS18R400)
        tireButton.apply(.blackS18R400)
        accidentButton.apply(.blackS18R400)
        
        for view in borderViews {
            view.backgroundColor = .disabled
        }
        borderViews[0].backgroundColor = .theme
    }
    
    func setTexts() {
        titleLabel.text = Strings.requests
        maintenanceButton.setTitle(Strings.care, for: .normal)
        breakdownButton.setTitle(Strings.fault, for: .normal)
        tireButton.setTitle(Strings.lastik, for: .normal)
        accidentButton.setTitle(Strings.accidentTab, for: .normal)
    }
    
    @IBAction func didTab(_ sender: UIView) {
        let tag = sender.tag
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension PastMaintenancesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: PastServicesHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 1:
            let cell: PastServicesSearchCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
            
        case 2:
            let cell: PastServicesItemsCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.items = viewModel.items
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 85
            
        case 1:
            height = 80
            
        case 2:
            let count = viewModel.items?.count ?? 0
            height = CGFloat(count * 168)
        default:
            break
        }
        
        return CGSize(width: collectionView.frame.width-32, height: height)
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

extension PastMaintenancesViewController: PastServicesSearchCellDelegate, PastServicesItemsCellDelegate {
    
    func didSelect(item: PastService) {
        
    }
    
    func didTapSort() {
        
    }
    
    func didTapFilter() {
        viewModel.presentFilters()
    }
    
    func didChangeSearch(text: String) {
        
    }
}

extension PastMaintenancesViewController: PastMaintenancesViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
