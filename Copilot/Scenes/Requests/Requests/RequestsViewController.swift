//
//  RequestsViewController.swift
//  Copilot
//
//  Created by Jamal on 3/4/24.
//

import Foundation
import UIKit

class RequestsViewController: UIViewController {
    
    var viewModel: RequestsViewModelType! {
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
        viewModel.goToReqFlw2Stp2Questions()
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: RequestsCell.self)
        collectionView.contentInset.top = 20
        collectionView.contentInset.bottom = 60
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        setBasicViews()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24R400)
        descriptionLabel.apply(.custom(.black, .regular, 11))
    }
    
    func setTexts() {
        titleLabel.text = Strings.requests
        descriptionLabel.text = Strings.requestsDescription
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension RequestsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: RequestsCell = collectionView.dequeueReusableCell(for: indexPath)
        switch indexPath.item {
        case 0:
            cell.label.text = Strings.productAndServiceRequests
            
        case 1:
            cell.label.text = Strings.processRequests
            
        case 2:
            cell.label.text = Strings.requestList
            
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-48, height: 57)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            viewModel.goToReqFlw1Stp2()
            
        case 1:
            viewModel.goToReqFlw2Stp2Questions()
            
        case 2:
            viewModel.goToRequestList()
            
        default:
            break
        }
    }
}

extension RequestsViewController: RequestsViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
