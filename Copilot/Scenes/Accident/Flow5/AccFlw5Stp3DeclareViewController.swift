//
//  AccFlw5Stp3DeclareViewController.swift
//  Copilot
//
//  Created by Jamal on 2/23/24.
//

import Foundation
import UIKit

class AccFlw5Stp3DeclareVController: UIViewController {
    
    var viewModel: AccFlw5Stp3DeclareViewModelType! {
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
        collectionView.register(cellType: AccFlw5Stp3HeaderCell.self)
        collectionView.register(cellType: AccFlw5Stp3ContentCell.self)
        collectionView.register(cellType: ReportImageCell.self)
        collectionView.register(cellType: AccFlw5Stp3ButtonsCell.self)
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

extension AccFlw5Stp3DeclareVController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return 3
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: AccFlw5Stp3HeaderCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 1:
            let cell: AccFlw5Stp3ContentCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 2:
            let cell: ReportImageCell = collectionView.dequeueReusableCell(for: indexPath)
          return cell
            
        case 3:
            let cell: AccFlw5Stp3ButtonsCell = collectionView.dequeueReusableCell(for: indexPath)
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
         height = 180
            
        case 1:
         height = 200
            
        case 2:
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
        if section == 2 {
            return UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension AccFlw5Stp3DeclareVController: AccFlw5Stp3ButtonsCellDelegate {
   
    func didTapUpload() {
        
    }
    
    func didTapContinue() {
        viewModel.goToAccFlow5Step4()
    }
}

extension AccFlw5Stp3DeclareVController: AccFlw5Stp3DeclareViewModelDelegate {
    
}