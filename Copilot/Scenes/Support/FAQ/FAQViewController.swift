//
//  FAQViewController.swift
//  Copilot
//
//  Created by Jamal on 3/19/24.
//

import Foundation
import UIKit

class FAQViewController: UIViewController {
    
    var viewModel: FAQViewModelType! {
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
        viewModel.getQuestions()
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
        collectionView.register(cellType: SupportItemCell.self)
        collectionView.contentInset.bottom = 70
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.frequentlyAskedQuestions
        
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension FAQViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SupportItemCell = collectionView.dequeueReusableCell(for: indexPath)
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
            viewModel.goToFAQQuestion(item: item)
            switch indexPath.item {
            case 0:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_CONDITION_LEASE")
               
            case 1:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_VEHICLE_OPERATION")
                
            case 2:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_HGS")
                
            case 3:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_MAINTENANCE_BREAKDOWN")
                
            case 4:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_ACCIDENT_DAMAGE")
                
            case 5:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_TIRE")
                
            case 6:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_SUBSTITUTE_VEHICLE")
                
            case 7:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_HEDEFNET_COPILOT")
                
            case 8:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_ACCOUNTING_TRANSACTION")
                
            case 9:
                APIService.addUserAction(pageName: "Help", actionName: "HELP_FAQ_VEHICLE_RETURN_PROCEDURES")
                
            default:
                break
            }
        }
    }
}

extension FAQViewController: FAQViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
