//
//  RequestListViewController.swift
//  Copilot
//
//  Created by Jamal on 3/17/24.
//

import Foundation
import UIKit

class RequestListViewController: UIViewController {
    
    var viewModel: RequestListViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var serviceRequestsLabel: UILabel!
    @IBOutlet weak var proccessRequestsLabel: UILabel!
    @IBOutlet var borderViews: [UIView]!
    @IBOutlet weak var collectionView: UICollectionView!
    private var currentTab = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: RequestListPageCell.self)
        //        collectionView.contentInset.bottom = 70
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS18B700)
        serviceRequestsLabel.apply(.blackS18R400)
        proccessRequestsLabel.apply(.blackS18R400)
        for view in borderViews {
            view.backgroundColor = .disabled
        }
        serviceRequestsLabel.textColor = .theme
        borderViews[0].backgroundColor = .theme
    }
    
    func setTexts() {
        titleLabel.text = Strings.requests
        serviceRequestsLabel.text = Strings.productAndServiceRequests
        proccessRequestsLabel.text = Strings.processRequests
    }
    
    @IBAction func didTab(_ sender: UIView) {
        let tag = sender.tag
        if tag == currentTab {
            return
        }
        borderViews[currentTab].backgroundColor = .disabled
        currentTab = tag
        borderViews[tag].backgroundColor = .theme
        serviceRequestsLabel.textColor = tag == 0 ? .theme: .black
        proccessRequestsLabel.textColor = tag == 1 ? .theme: .black
        collectionView.scrollToItem(at: IndexPath(row: 0, section: tag), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension RequestListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: RequestListPageCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
            
        case 1:
            let cell: RequestListPageCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension RequestListViewController: RequestListPageCellDelegate {
    func didSelect(item: String) {
        viewModel.goToRequestDetail(title: item)
    }
}

extension RequestListViewController: RequestListViewModelDelegate {
    
}
