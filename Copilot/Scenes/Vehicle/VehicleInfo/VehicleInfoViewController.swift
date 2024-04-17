//
//  VehicleInfoViewController.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import Foundation
import UIKit

class VehicleInfoViewController: UIViewController {
    
    var viewModel: VehicleInfoViewModelType! {
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
        viewModel.getDocuments()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: VehicleCell.self)
        collectionView.register(cellType: VehicleInfoItemCell.self)
        collectionView.register(cellType: VehicleInfoButtonsCell.self)
        collectionView.contentInset.bottom = 60
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.vehicleInformation
    }
}

extension VehicleInfoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return viewModel.documents?.count ?? 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: VehicleCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.vehicle = App.vehicle
            return cell
            
        case 1:
            let cell: VehicleInfoItemCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = viewModel.documents?[indexPath.item].name
            cell.item = viewModel.documents?[indexPath.item]
            cell.delegate = self
            return cell
            
        case 2:
            let cell: VehicleInfoButtonsCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 315
            
        case 1:
            height = 50
            
        case 2:
            height = 172
            
        default:
            break
        }
        return CGSize(width: collectionView.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 16
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1, let item =  viewModel.documents?[indexPath.item] {
            viewModel.goToDocument(document: item)
        }
    }
}

extension VehicleInfoViewController: VehicleInfoButtonsCellDelegate, VehicleInfoItemCellDelegate {
    
    func didTapGuide() {
        viewModel.goToVehicleGuide()
    }
    
    func didTapRequests() {
        viewModel.goToRequests()
    }
    
    func didTapDownload(document: Document) {
        APIService.addUserAction(pageName: "Car Informations", actionName: "CAR_INFORMATION_PRIVATE_VEHICLE_CONTRACT_DOWNLOAD")
        viewModel.getDocument(document: document)
    }
}

extension VehicleInfoViewController: VehicleInfoViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func showShareView(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
