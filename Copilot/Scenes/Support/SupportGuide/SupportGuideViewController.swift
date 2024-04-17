//
//  SupportGuideViewController.swift
//  Copilot
//
//  Created by Jamal on 3/20/24.
//

import Foundation
import UIKit

class SupportGuideViewController: UIViewController {
    
    var viewModel: SupportGuideViewModelType! {
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
        viewModel.getGuides()
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
        collectionView.register(cellType: SupportGuideCell.self)
        collectionView.contentInset.bottom = 70
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.supportGuidesMenuTitle
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension SupportGuideViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SupportGuideCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.item = viewModel.items?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-48, height: 57)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = viewModel.items?[indexPath.item] {
            viewModel.goToSupportGuideDetail(item: item)
            switch indexPath.item { 
            case 0:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_GUIDE_VEHICLE_USER_MANUAL")
            case 1:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_GUIDE_VEHICLE_RETURN_GUIDE")
            case 2:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_GUIDE_WARNING_LIGHTS_GUIDE")
                
            case 3:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_GUIDE_ACCIDENT_GUIDE")
            case 4:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_GUIDE_PRODUCT_CATALOG")
            default:
                break
            }
        }
    }
}

extension SupportGuideViewController: SupportGuideViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
