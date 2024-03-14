//
//  BrkdwnFlw2Stp3WarningLightsVController.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation
import UIKit

class BrkdwnFlw2Stp3WarningLightsVController: UIViewController {
    
    var viewModel: BrkdwnFlw2Stp3WarningLightsViewModelType! {
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
        for item in viewModel.warnings {
            item.selected = false
        }
    }
    
    func setupUI() {
        setBasicViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: WarningLightsHeaderCell.self)
        collectionView.register(cellType: WarningItemCell.self)
        collectionView.register(cellType: WarningLightsFooterCell.self)
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
        titleLabel.text = Strings.breakDownOperations
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension BrkdwnFlw2Stp3WarningLightsVController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return viewModel.warnings.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: WarningLightsHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 1:
            let cell: WarningItemCell = collectionView.dequeueReusableCell(for: indexPath)
//            cell.delegate = self
            let image = UIImage(named: viewModel.warnings[indexPath.item].image)
            cell.imageView.image = image
            return cell
            
        case 2:
            let cell: WarningLightsFooterCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
        
        default:
            return UICollectionViewCell()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 353
        switch indexPath.section {
        case 0:
         height = 145
            
        case 1:
//           height = 648
            let width: CGFloat = 64
            return CGSize(width: width, height: width)
            
        case 2:
          height = 136
            
        default:
            break
        }
        
        return CGSize(width: collectionView.frame.width-48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 24
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 24
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let item = viewModel.warnings[indexPath.item]
            item.selected = true
            viewModel.goToBrkdwnFlw2Stp4SelectedWarnings(item: item)
        }
    }
}

extension BrkdwnFlw2Stp3WarningLightsVController: WarningItemsCellDelegate,
                                                  WarningLightsFooterCellDelegate {
    func didSelectItem() {
        
    }
    
    func didTabBack() {
        viewModel.getBack()
    }
    
    func didTapGoToGuide() {
        
    }
}

extension BrkdwnFlw2Stp3WarningLightsVController: BrkdwnFlw2Stp3WarningLightsVMDelegate {
    func setBrkdwnFlw2Stp3WarningLights() {
        collectionView.reloadData()
    }
}
