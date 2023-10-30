//
//  FilteresViewController.swift
//  Copilot
//
//  Created by Jamal on 10/30/23.
//

import Foundation
import UIKit

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
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTextField: CPSearchTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var applyButton: CPButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
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
        titleLabel.text = Strings.filters
        applyButton.setTitle(Strings.apply, for: .normal)
        searchTextField.attributedPlaceholder = NSAttributedString(string: Strings.searchFilter, attributes: [
            .foregroundColor: UIColor.textGrey,
            .font: FontTypographyType.greyS16B400.font
        ])
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        viewModel.dismiss()
    }
    
    @IBAction func didTapApply(_ sender: UIButton) {
        viewModel.dismiss()
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
            return
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? SubFiltersCell {
            filter.showSubFilters = !filter.showSubFilters
            cell.toggle()
            collectionView.performBatchUpdates(nil)
        }
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

extension FiltersViewController: FiltersViewModelDelegate {
    
}
