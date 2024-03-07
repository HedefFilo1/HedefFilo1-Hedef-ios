//
//  ReqFlw2Stp2QuestionsViewController.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation
import UIKit

class ReqFlw2Stp2QuestionsViewController: UIViewController {
    
    var viewModel: ReqFlw2Stp2QuestionsViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
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
        collectionView.register(cellType: ReqFlw2Stp2QuestionsCell.self)
        collectionView.contentInset.top = 20
        collectionView.contentInset.bottom = 90
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        setBasicViews()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24R400)
        descriptionLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.processRequests
        descriptionLabel.text = Strings.requestsQuestionDescription
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension ReqFlw2Stp2QuestionsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ReqFlw2Stp2QuestionsCell = collectionView.dequeueReusableCell(for: indexPath)
        switch indexPath.item {
        case 0:
            cell.label.text = Strings.completedVehicleOperations
            
        case 1:
            cell.label.text = Strings.hgsOperations
            
        case 2:
            cell.label.text = Strings.plateLicenseOperations
            
        case 3:
            cell.label.text = Strings.lostLicenseOperations
            
        case 4:
            cell.label.text = Strings.inspectionOperations
            
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-48, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            viewModel.goToReqFlw2Stp3Vehicle()
            
        case 1:
            viewModel.goToReqFlw3Stp3HGS()
            
            //        case 2:
            
        default:
            break
        }
    }
}

extension ReqFlw2Stp2QuestionsViewController: ReqFlw2Stp2QuestionsViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
