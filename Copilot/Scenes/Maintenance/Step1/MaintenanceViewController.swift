//
//  MaintenanceViewController.swift
//  Copilot
//
//  Created by Jamal on 1/30/24.
//

import Foundation
import UIKit

class MaintenanceViewController: UIViewController {
    
    var viewModel: MaintenanceViewModelType! {
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
        
#if DEV_DEBUG
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: MaintenanceCell.self)
        collectionView.register(cellType: MaintenanceRandevuCell.self)
        collectionView.contentInset.top = 12
        collectionView.contentInset.bottom = 90
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.maintenanceOperations
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension MaintenanceViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if viewModel.appointment == nil {
            let cell: MaintenanceCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
        } else {
            
            let cell: MaintenanceRandevuCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.appointment = viewModel.appointment
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 353
        
        if viewModel.appointment != nil {
            height = collectionView.frame.height - 90
        }
        return CGSize(width: collectionView.frame.width-32, height: height)
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

extension MaintenanceViewController: MaintenanceCellDelegate,
                                     MaintenanceRandevuCellDelegate {
    func didTapRandevu() {
        
        APIService.addUserAction(pageName: "Services", actionName: "SERVICE_MAINTENANCE_MAKE_MAINTENANCE_APPOINTMENT")
        viewModel.goToMaintenanceStep2KM()
    }
    
    func didTapEdit() {
        viewModel.goToServiceDetail()
    }
}

extension MaintenanceViewController: MaintenanceViewModelDelegate {
    func setMaintenance() {
        collectionView.reloadData()
    }
}
