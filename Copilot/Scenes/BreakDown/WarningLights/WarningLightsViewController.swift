//
//  WarningLightsViewController.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import Foundation
import UIKit

protocol WarningLightsViewControllerDelegate: AnyObject {
    func didSelect(item: MockWarning)
}

class WarningLightsViewController: UIViewController {
    
    var viewModel: WarningLightsViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    weak var delegate: WarningLightsViewControllerDelegate?
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
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.servicebreakdown.breakdown.operation.title")
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension WarningLightsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
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
            let item = viewModel.warnings[indexPath.item]
            let image = UIImage(named: item.image)
            cell.imageView.image = image
            cell.haSelected = item.selected
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
            if item.selected {
                item.selected = false
                if let cell = collectionView.cellForItem(at: indexPath) as? WarningItemCell {
                    cell.haSelected = false
                }
                return
            }
            item.selected = true
            delegate?.didSelect(item: item)
            viewModel.getBack()
        }
    }
}

extension WarningLightsViewController: WarningItemsCellDelegate,
                                       WarningLightsFooterCellDelegate {
    func didSelectItem() {
        
    }
    
    func didTabBack() {
        viewModel.getBack()
    }
    
    func didTapGoToGuide() {
        
    }
}

extension WarningLightsViewController: WarningLightsViewModelVMDelegate {
    
}
