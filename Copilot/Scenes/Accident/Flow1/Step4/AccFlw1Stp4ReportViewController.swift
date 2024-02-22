//
//  AccFlw1Stp4ReportViewController.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import UIKit

class AccFlw1Stp4ReportViewController: UIViewController {
    
    var viewModel: AccFlw1Stp4ReportViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var button: CPButton!
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: AccFlw1Stp4ReportHeaderCell.self)
        collectionView.register(cellType: AccFlw1Stp4ReportTitleCell.self)
        collectionView.register(cellType: AccFlw1Stp4ReportImageCell.self)
        collectionView.register(cellType: UploadPhotoCell.self)
        collectionView.contentInset.bottom = 20
        button.isEnabled = true
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setTexts() {
//        let text = "\(Strings.devamEt) (1 \(Strings.photoSelected))"
        button.setTitle(Strings.devamEt, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapContinue() {
        viewModel.goToAccFlw1Stp5Leaks()
    }
    
}

extension AccFlw1Stp4ReportViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section != 0 {
            return 2
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: AccFlw1Stp4ReportHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 1:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = Strings.report
                return cell
            }
            
            let cell: AccFlw1Stp4ReportImageCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 2:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = Strings.competenceOfOtherParty
                return cell
            }
            
            let cell: UploadPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 3:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = Strings.insurancePolicyOfOtherParty
                return cell
            }
            
            let cell: UploadPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 4:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = Strings.otherPartysLicense
                return cell
            }
            
            let cell: UploadPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 5:
            if indexPath.item == 0 {
                let cell: AccFlw1Stp4ReportTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = Strings.photosOfVehicle
                return cell
            }
            
            let cell: UploadPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        
        default:
            return UICollectionViewCell()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 353
        switch indexPath.section {
        case 0:
         height = 191
            
        case 1:
            height = indexPath.item == 0 ? 17: 120
            
        default:
            height = indexPath.item == 0 ? 17: 32
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

extension AccFlw1Stp4ReportViewController: AccFlw1Stp4ReportViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
