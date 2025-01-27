//
//  ServiceOperationsViewController.swift
//  Copilot
//
//  Created by Jamal on 3/22/24.
//

import Foundation
import UIKit
import CoreLocation

class ServiceOperationsViewController: UIViewController {
    
    var viewModel: ServiceOperationsViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var filtering = false
    private var searchText = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getServices()
#if DEV_DEBUG
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ServiceOperationsSearchCell.self)
        collectionView.register(cellType: ServicesOperationItemsCell.self)
        collectionView.contentInset.bottom = 12
        collectionView.contentInset.bottom = 70
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS24B700)
        descriptionLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.help.feedback.service.operation")
        descriptionLabel.text = App.getString(key: "copilotapp.help.feedback.service.operation.body")
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension ServiceOperationsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: ServiceOperationsSearchCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.setFilter(item: viewModel.filterItem?.title)
            return cell
        }
        
        let cell: ServicesOperationItemsCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.items = viewModel.filteredServices
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let hasFilter = viewModel.filterItem != nil
            let height: CGFloat = hasFilter ? 110: 74
            return CGSize(width: collectionView.frame.width, height: height)
        } else {
            
            let count = viewModel.filteredServices.count + 2
            let height = CGFloat((count * 77) + (count * 12)) - 12 + 24
            return CGSize(width: collectionView.frame.width, height: height)
        }
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

extension ServiceOperationsViewController: ServiceOperationsSearchCellDelegate {
    
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
            self.collectionView.reloadSections(IndexSet(integer: 1))
            self.filtering = false
        }
        
    }
    
    func didTapFilter() {
        viewModel.presentFitlers()
    }
}

extension ServiceOperationsViewController: ServicesOperationItemsCellDelegate {
    func didSelect(item: ServiceOperation) {
        let id = item.id ?? ""
        let date = item.displayDate
        viewModel.presentFeedbackRate(caseId: id, date: date)
    }
}

extension ServiceOperationsViewController: ServiceOperationsViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
