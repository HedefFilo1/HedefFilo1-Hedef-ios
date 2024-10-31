//
//  RequestListViewController.swift
//  Copilot
//
//  Created by Jamal on 3/17/24.
//

import Foundation
import UIKit

class RequestListTasksViewController: UIViewController {
    
    var viewModel: RequestListTasksViewModel! {
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
        viewModel.getTasks()
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
        collectionView.register(cellType: RequestListCountCell.self)
        collectionView.register(cellType: RequestListItemCell.self)
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
        serviceRequestsLabel.textColor = .theme
        borderViews[0].backgroundColor = .theme
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.demandlist.title")
        serviceRequestsLabel.text = App.getString(key: "copilotapp.demandlist.product.process.request.product.tab")
        proccessRequestsLabel.text = App.getString(key: "copilotapp.demandlist.product.process.request.tab")
    }
    
    @IBAction func didTab(_ sender: UIView) {
        viewModel.showRequestsList()
        //        let tag = sender.tag
        //        if tag == currentTab {
        //            return
        //        }
        //        borderViews[currentTab].backgroundColor = .disabled
        //        currentTab = tag
        //        borderViews[tag].backgroundColor = .theme
        //        serviceRequestsLabel.textColor = tag == 0 ? .theme: .black
        //        proccessRequestsLabel.textColor = tag == 1 ? .theme: .black
        //        collectionView.scrollToItem(at: IndexPath(row: 0, section: tag), at: .centeredHorizontally, animated: true)
        //        if tag == 1, viewModel.requests == nil {
        //            viewModel.getRequests()
        //        }
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension RequestListTasksViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }
        return viewModel.filteredTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: RequestListSearchCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.filterLabel.text = App.getString(key: "copilotapp.service.service.list.productservice.filter")
            cell.sortLabel.text = App.getString(key: "copilotapp.service.service.list.productservice.sort")
            cell.descriptionLabel.text = App.getString(key: "copilotapp.demandlist.operation.tab.description")
            cell.setFilter(item: viewModel.filterItem?.title)
            return cell
            
        case 1:
            let cell: RequestListCountCell = collectionView.dequeueReusableCell(for: indexPath)
            var text = App.getString(key: "copilotapp.service.service.list.productservice.description") ?? ""
            text = text.replacingOccurrences(of: "{number}", with: "")
            let count = viewModel.filteredTasks.count
            cell.itemsCount = "\(count) \(text)"
            return cell
            
        case 2:
            let cell: RequestListItemCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.item = viewModel.filteredTasks[indexPath.item]
            return cell
            //        case 0:
            //            let cell: RequestListPageCell = collectionView.dequeueReusableCell(for: indexPath)
            //            cell.delegate = self
            //            cell.items = viewModel.tasks
            //            cell.label.text = App.getString(key: "copilotapp.demandlist.operation.tab.description")
            //            return cell
            //
            //        case 1:
            //            let cell: RequestListPageCell = collectionView.dequeueReusableCell(for: indexPath)
            //            cell.delegate = self
            //            cell.items = nil
            //            cell.requestItems = viewModel.requests
            //            cell.label.text = App.getString(key: "copilotapp.demandlist.product.tab.description")
            //            return cell
            
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
        } else {
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

extension RequestListTasksViewController: RequestListSearchCellDelegate {
    
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
            self.collectionView.reloadSections(IndexSet(integer: 1))
            self.filtering = false
        }
        
    }
    
    func didTapFilter() {
        viewModel.presentFitlers()
    }
    
    func didTapSort() {
        viewModel.presentSort()
    }
    
}

extension RequestListTasksViewController: RequestListPageCellDelegate {
    func didSelect(item: Task) {
        viewModel.goToRequestDetail(item: item)
    }
}

extension RequestListTasksViewController: RequestListTasksViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
