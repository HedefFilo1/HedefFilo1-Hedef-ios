//
//  BrkdwnFlw2Stp4SelectedWarningsVCntlr.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import Foundation
import UIKit

class BrkdwnFlw2Stp4SelectedWarningsVCntlr: UIViewController {
    
    var viewModel: BrkdwnFlw2Stp4SelectedWarningsVMType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
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
        collectionView.register(cellType: SelectedWarningItemCell.self)
        collectionView.register(cellType: SelectedWarningsContentCell.self)
        collectionView.register(cellType: JustYellowWarningCell.self)
        collectionView.register(cellType: SelectedWarningsButtonsCell.self)
        collectionView.contentInset.bottom = 60
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {

    }
    
    func setTexts() {
        
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension BrkdwnFlw2Stp4SelectedWarningsVCntlr: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.warnings?.count ?? 0
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: SelectedWarningItemCell = collectionView.dequeueReusableCell(for: indexPath)
            if let name = viewModel.warnings?[indexPath.item].image {
                let image = UIImage(named: name)
                cell.imageView.image = image
            }
            return cell
            
        case 1:
            if !viewModel.isTowTruck {
                let cell: JustYellowWarningCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.label.text = viewModel.message
                return cell
                
            } else {
                let cell: SelectedWarningsContentCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.delegate = self
                return cell
            }
        case 2:
            let cell: SelectedWarningsButtonsCell = collectionView.dequeueReusableCell(for: indexPath)
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
         height = 118
            
        case 1:
            if !viewModel.isTowTruck {
                height = 100
            } else {
                height = 312
            }
            
        case 2:
            height = 288
            
        default:
            break
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

extension BrkdwnFlw2Stp4SelectedWarningsVCntlr: SelectedWarningsContentCellDelegate,
                                                SelectedWarningsButtonsCellDelegate {
    
    func didTapShowLocation() {
            
    }
    
    func didTapChooseAnother() {
        viewModel.goToWarningLights()
    }
    
    func didTapServices() {
        viewModel.goToServices()
    }
    
    func didTapCall() {
        
    }
}

extension BrkdwnFlw2Stp4SelectedWarningsVCntlr: BrkdwnFlw2Stp4SelectedWarningsVMDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
