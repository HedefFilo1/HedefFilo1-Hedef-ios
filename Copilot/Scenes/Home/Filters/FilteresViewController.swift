//
//  FilteresViewController.swift
//  Copilot
//
//  Created by Jamal on 10/30/23.
//

import Foundation
import UIKit

protocol FiltersViewControllerDelegate: AnyObject {
    func didApply(filters: [Filter])
}

class FiltersViewController: SheetViewController {
    
    var viewModel: FiltersViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        let top = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        return UIScreen.main.bounds.height - 120 - top
    }
    
    weak var delegate: FiltersViewControllerDelegate?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTextField: CPSearchTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var applyButton: CPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        APIService.addUserAction(pageName: "HOMEPAGE", actionName: "HOMEPAGE_NEAR_FILTER")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: FilterCell.self)
        collectionView.register(cellType: SubFiltersCell.self)
        applyStyle()
        setTexts()
        applyButton.isEnabled = false
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS18B700)
        searchTextField.setGreyTint()
    }
    
    func setTexts() {
        titleLabel.text =  App.getString(key: "copilotapp.homepage.near.button")
        applyButton.setTitle(Strings.apply, for: .normal)
        searchTextField.attributedPlaceholder = NSAttributedString(string: Strings.searchFilter, attributes: [
            .foregroundColor: UIColor.textGrey,
            .font: FontTypographyType.greyS16R400.font
        ])
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        viewModel.dismiss()
    }
    
    @IBAction func didTapApply(_ sender: UIButton) {
        
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let filters = self.viewModel.filters.filter({
                return $0.selected
            })
            self.delegate?.didApply(filters: filters)
        }
    }
    
    func setButtonActivation() {
        
        for filter in viewModel.filters {
            if filter.selected {
                applyButton.isEnabled = true
                return
            }
            
            if let filters = filter.subFilters {
                for filter in filters where filter.selected {
                    applyButton.isEnabled = true
                    return
                }
            }
        }
        applyButton.isEnabled = false
    }
}

extension FiltersViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filter = viewModel.filters[indexPath.item]
        
        if let subFilters = filter.subFilters {
            let cell: SubFiltersCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.item = filter
            cell.items = subFilters
            cell.delegate = self
            return cell
        }
        
        let cell: FilterCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.item = filter
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = viewModel.filters[indexPath.item]
        
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterCell {
            filter.selected = !filter.selected
            cell.checkBox.isSelected = filter.selected
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? SubFiltersCell {
            filter.showSubFilters = !filter.showSubFilters
            cell.toggle()
            collectionView.performBatchUpdates(nil)
        }
        
        setButtonActivation()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let filter = viewModel.filters[indexPath.item]
        var height: CGFloat = 48
        if filter.showSubFilters {
            let count = filter.subFilters?.count ?? 0
            height = CGFloat((count * 48) + 48)
        }
        return CGSize(width: collectionView.frame.width-32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension FiltersViewController: SubFiltersCellDelegate {
    func didSelectItem() {
        setButtonActivation()
    }
}

extension FiltersViewController: FiltersViewModelDelegate {
    
}
