//
//  StandingsViewController.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import Foundation
import UIKit

class StandingsViewController: UIViewController {
    
    var viewModel: StandingsViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getTotalPoints()
         
        APIService.addUserAction(pageName: "HOMEPAGE", actionName: "HOMEPAGE_HOW_EARN_POINTS")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: StandingCell.self)
        collectionView.register(cellType: StandingItemCell.self)
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.standings
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
}

extension StandingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1: 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: StandingCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.totalPoints = viewModel.totalPoints
            cell.barPoints = viewModel.barPoints
            return cell
        }
        
        let cell: StandingItemCell = collectionView.dequeueReusableCell(for: indexPath)
        switch indexPath.item {
        case 0:
            cell.titleLabel.text = Strings.createProccessRequestSel
            cell.point = 500
        case 1:
            cell.titleLabel.text = Strings.fillOutSatisfaction
            cell.point = 50
            
        case 2:
            cell.titleLabel.text = Strings.createServiceRequest
            cell.point = 100
            
        case 3:
            cell.titleLabel.text = Strings.createProductRequest
            cell.point = 200
            
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: collectionView.frame.width-48, height: indexPath.section == 0 ? 244: 57)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension StandingsViewController: StandingsViewModelDelegate {
    func setTotalPoints() {
        collectionView.reloadData()
    }
    
    func setBarPoints() {
        collectionView.reloadData()
    }
}
