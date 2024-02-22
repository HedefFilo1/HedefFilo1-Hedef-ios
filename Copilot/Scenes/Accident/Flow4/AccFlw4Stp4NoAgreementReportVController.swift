//
//  AccFlw4Stp4NoAgreementReportVController.swift
//  Copilot
//
//  Created by Jamal on 2/22/24.
//

import Foundation
import UIKit

class AccFlw4Stp4NoAgreementReportVController: UIViewController {
    
    var viewModel: AccFlw4Stp4NoAgreementReportViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: AccFlw4Stp4HeaderCell.self)
        collectionView.register(cellType: ReportImageCell.self)
        collectionView.register(cellType: AccFlw4SelectPhotoCell.self)
        collectionView.contentInset.top = 34
        collectionView.contentInset.bottom = 20
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
        
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension AccFlw4Stp4NoAgreementReportVController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 10
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: AccFlw4Stp4HeaderCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 1:
            let cell: ReportImageCell = collectionView.dequeueReusableCell(for: indexPath)
          return cell
            
        case 2:
            
            let cell: AccFlw4SelectPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        
        default:
            return UICollectionViewCell()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        
        switch indexPath.section {
        case 0:
         height = 210
            
        case 1:
            return CGSize(width: 104, height: 104)
            
        default:
            height = 176 + 90
        }
        
        return CGSize(width: collectionView.frame.width-32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension AccFlw4Stp4NoAgreementReportVController: AccFlw4Stp4NoAgreementReportViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
