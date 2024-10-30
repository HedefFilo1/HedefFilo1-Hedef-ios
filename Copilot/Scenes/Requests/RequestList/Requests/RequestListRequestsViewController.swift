//
//  RequestListViewController.swift
//  Copilot
//
//  Created by Jamal on 3/17/24.
//

import Foundation
import UIKit

class RequestListRequestsViewController: UIViewController {
    
    var viewModel: RequestListRequestsViewModel! {
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
    private var searchText = ""
    private var filtering = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getRequests()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        setBasicViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: RequestListSearchCell.self)
        //        collectionView.register(cellType: RequestListPageCell.self)
        collectionView.register(cellType: RequestListItemCell.self)
        collectionView.register(cellType: RequestListCountCell.self)
        collectionView.contentInset.top = 16
        collectionView.contentInset.bottom = 70
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24R400)
        serviceRequestsLabel.apply(.blackS18R400)
        serviceRequestsLabel.numberOfLines = 2
        proccessRequestsLabel.apply(.blackS18R400)
        proccessRequestsLabel.numberOfLines = 2
        for view in borderViews {
            view.backgroundColor = .disabled
        }
        proccessRequestsLabel.textColor = .theme
        borderViews[1].backgroundColor = .theme
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.demandlist.title")
        serviceRequestsLabel.text = App.getString(key: "copilotapp.demandlist.product.process.request.product.tab")
        proccessRequestsLabel.text = App.getString(key: "copilotapp.demandlist.product.process.request.tab")
    }
    
    @IBAction func didTab(_ sender: UIView) {
        viewModel.showTasksList()
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension RequestListRequestsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }
        return viewModel.requests?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: RequestListSearchCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.filterLabel.text = App.getString(key: "copilotapp.service.service.list.processrequest.filter")
            cell.descriptionLabel.text = App.getString(key: "copilotapp.demandlist.product.tab.description")
            return cell
            
        case 1:
            let cell: RequestListCountCell = collectionView.dequeueReusableCell(for: indexPath)
            var text = App.getString(key: "copilotapp.service.service.list.processrequest.description") ?? ""
            text = text.replacingOccurrences(of: "{number}", with: "")
            let count = viewModel.requests?.count ?? 0
            cell.itemsCount = "\(count) \(text)"
            return cell
            
        case 2:
            let cell: RequestListItemCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.request = viewModel.requests?[indexPath.item]
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width-32
        if indexPath.section == 0 {
            let hasFilter = viewModel.filterItem != nil
            let height: CGFloat = hasFilter ? 146: 100
            return CGSize(width: width, height: height)
            
        } else if indexPath.section == 1 {
            return CGSize(width: width, height: 24)
        }
        else {
            return CGSize(width: width, height: 48)
        }
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

extension RequestListRequestsViewController: RequestListSearchCellDelegate {
    
    func didTapRemoveFilter() {
        viewModel.filterItem = nil
        collectionView.reloadData()
    }
    
    func didChangeSearch(text: String) {
        searchText = text
        if filtering {
            return
        }
        filtering = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) {
            self.viewModel.searchText = self.searchText
            self.collectionView.reloadSections(IndexSet(integer: 2))
            self.filtering = false
        }
        
    }
    
    func didTapFilter() {
        viewModel.presentFitlers()
    }
    
}

extension RequestListRequestsViewController: RequestListPageCellDelegate {
    func didSelect(item: Task) {
        viewModel.goToRequestDetail(item: item)
    }
}

extension RequestListRequestsViewController: RequestListRequestsViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
