//
//  PastMaintenancesViewController.swift
//  Copilot
//
//  Created by Jamal on 3/28/24.
//

import Foundation
import UIKit

class PastMaintenancesViewController: UIViewController {
    
    var viewModel: PastMaintenancesViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maintenanceButton: UIButton!
    @IBOutlet var borderViews: [UIView]!
    @IBOutlet weak var breakdownButton: UIButton!
    @IBOutlet weak var tireButton: UIButton!
    @IBOutlet weak var accidentButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var headTitle = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.past.maintenance.operation.title") ?? Strings.pastMaintenanceOperations
    private var message =  App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.description") ?? Strings.pastMaintenanceDescription
    private var foundMessage = Strings.pastMaintenanceFound
    var currentTab = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getServices()
    }

    func setupUI() {
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: PastServicesHeaderCell.self)
        collectionView.register(cellType: PastServicesSearchCell.self)
        collectionView.register(cellType: PastServicesItemsCell.self)
        collectionView.contentInset.top = 24
        collectionView.contentInset.bottom = 70
        changeTab(tab: viewModel.tab)
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        maintenanceButton.apply(.blackS18R400)
        maintenanceButton.titleLabel?.numberOfLines = 2
        maintenanceButton.titleLabel?.textAlignment = .center
        maintenanceButton.setTitleColor(.theme, for: .normal)
        breakdownButton.apply(.blackS18R400)
        breakdownButton.titleLabel?.numberOfLines = 2
        breakdownButton.titleLabel?.textAlignment = .center
        tireButton.apply(.blackS18R400)
        tireButton.titleLabel?.numberOfLines = 2
        tireButton.titleLabel?.textAlignment = .center
        accidentButton.apply(.blackS18R400)
        accidentButton.titleLabel?.numberOfLines = 2
        accidentButton.titleLabel?.textAlignment = .center
        
        for view in borderViews {
            view.backgroundColor = .disabled
        }
        borderViews[0].backgroundColor = .theme
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.past.service.operation.button")
        
        maintenanceButton.setTitle(App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.tab.maintenance"), for: .normal)
        breakdownButton.setTitle(App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.tab.breakdown"), for: .normal)
        tireButton.setTitle(App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.tab.tire"), for: .normal)
        accidentButton.setTitle(App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.tab.accident.damage"), for: .normal)
    }
    
    func setButtonsColor(tab: Int) {
        
        for view in borderViews {
            view.backgroundColor = .disabled
        }
        borderViews[tab].backgroundColor = .theme
        maintenanceButton.setTitleColor(tab == 0 ? .theme: .black, for: .normal)
        breakdownButton.setTitleColor(tab == 1 ? .theme: .black, for: .normal)
        tireButton.setTitleColor(tab == 2 ? .theme: .black, for: .normal)
        accidentButton.setTitleColor(tab == 3 ? .theme: .black, for: .normal)
    }
    
    func setTitleTexts(tab: Int) {
        let title =  Strings.pastMaintenanceOperations
        let message = Strings.pastMaintenanceDescription
        let foundMessage = Strings.pastMaintenanceFound
        var replaceTitle = Strings.care
        switch tab {
        case 0:
            replaceTitle = Strings.care
            
        case 1:
            replaceTitle = Strings.fault
            
        case 2:
            replaceTitle = Strings.lastik
            
        case 3:
            replaceTitle = Strings.accidentTab
            
        default:
            break
        }
        headTitle = title.replacingOccurrences(of: Strings.care, with: replaceTitle)
        self.message = message.replacingOccurrences(of: Strings.care.lowercaseFirstLetter(), with: replaceTitle.lowercaseFirstLetter())
        self.foundMessage = foundMessage.replacingOccurrences(of: Strings.care, with: replaceTitle)
        
    }
    
    func setServiceType(tab: Int) {
        switch tab {
        case 0:
            viewModel.type = .maintenance
            
        case 1:
            viewModel.type = .mechanicalFailure
            
        case 2:
            viewModel.type = .tireChange
            
        case 3:
            viewModel.type = .damage
            
        default:
            break
        }
    }
    
    func changeTab(tab: Int) {
        currentTab = tab
        setButtonsColor(tab: tab)
        setTitleTexts(tab: tab)
        viewModel.items = []
        collectionView.reloadData()
        setServiceType(tab: tab)
        viewModel.getServices()
        if tab == 0 {
            APIService.addUserAction(pageName: "Services", actionName: "SERVICE_PAST_SERVICE_OPERATIONS_MAINTENANCE_TAB_CLICK")
        }
        
        if tab == 1 {
            APIService.addUserAction(pageName: "Services", actionName: "SERVICE_PAST_SERVICE_OPERATIONS_BREAKDOWN_TAB_CLICK")
        }
        
        if tab == 2 {
            APIService.addUserAction(pageName: "Services", actionName: "SERVICE_PAST_SERVICE_OPERATIONS_TIRE_TAB_CLICK")
        }
        
        if tab == 3 {
            APIService.addUserAction(pageName: "Services", actionName: "SERVICE_PAST_SERVICE_OPERATIONS_ACCIDENT_DAMAGE_TAB_CLICK")
        }
    }
    
    @IBAction func didTabOnTap(_ sender: UIView) {
        let tag = sender.tag
        changeTab(tab: tag)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension PastMaintenancesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: PastServicesHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = headTitle
            cell.descriptionLabel.text = message
            return cell
            
        case 1:
            let cell: PastServicesSearchCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
            
        case 2:
            let cell: PastServicesItemsCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.foundMessage = foundMessage
            cell.delegate = self
            cell.items = viewModel.items
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 85
            
        case 1:
            height = 80
            
        case 2:
            let count = viewModel.items?.count ?? 0
            height = CGFloat(count * 168) + 30
        default:
            break
        }
        
        return CGSize(width: collectionView.frame.width-32, height: height)
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

extension PastMaintenancesViewController: PastServicesSearchCellDelegate, PastServicesItemsCellDelegate {
    
    func didSelect(item: PastService) {
        var title = Strings.care
        switch currentTab {
        case 0:
            title = Strings.care
            
        case 1:
            title = Strings.fault
            
        case 2:
            title = Strings.lastik
            
        case 3:
            title = Strings.accidentTab
        default:
            break
        }
        viewModel.goToPastServiceDetail(service: item, title: title)
    }
    
    func didTapSort() {
        viewModel.presentSort()
    }
    
    func didTapFilter() {
        viewModel.presentFilters()
    }
    
    func didChangeSearch(text: String) {
        
    }
}

extension PastMaintenancesViewController: PastMaintenancesViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
