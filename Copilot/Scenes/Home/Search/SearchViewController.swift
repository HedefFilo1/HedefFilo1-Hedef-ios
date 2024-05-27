//
//  SearchViewController.swift
//  Copilot
//
//  Created by Jamal on 11/17/23.
//

import Foundation
import UIKit

class SearchViewController: PopupViewController {
    
    // MARK: - Properties
    var viewModel: SearchViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var searchTextField: CPSearchTextField!
    @IBOutlet weak var clearView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        APIService.addUserAction(pageName: "HOMEPAGE", actionName: "HOMEPAGE_PAST_SEARCH")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabbarView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabbarView()
    }
    private func setupUI() {
        setupCollectionView()
        applyStyles()
        setTexts()
        searchTextField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        searchTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        clearView.isHidden = true
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerSupplementaryView(cellType: SearchHeaderCell.self)
        collectionView.register(cellType: PastSearchCell.self)
        collectionView.register(cellType: GuideCell.self)
    }
    
    private func applyStyles() {
        view.backgroundColor = .white
        searchTextField.setTint(color: .fieldsTitle)
        searchTextField.apply(.custom(.fieldsText, .regular, 14))
        searchTextField.textPadding.right = 40
        cancelButton.apply(.blackS14B700)
    }
    
    func setTexts() {
        searchTextField.placeholder = App.getString(key: "copilotapp.homepage.searchbox.description")
        cancelButton.setTitle(App.getString(key: "copilotapp.homepage.searchbox.cancel.button"), for: .normal)
    }
    
    @objc func editingDidBegin() {
        searchTextField.searchIcon.tintColor = .fieldsText
    }
    
    @objc func editingChanged() {
        let count = searchTextField.text?.count ?? 0
        clearView.isHidden = count == 0
        viewModel.searchText = searchTextField.text ?? ""
        collectionView.reloadData()
    }
    
    @objc func editingDidEnd() {
        let count = searchTextField.text?.count ?? 0
        searchTextField.searchIcon.tintColor = count > 0 ? .fieldsText: .fieldsTitle
    }
    
    @IBAction func didTapClear() {
        searchTextField.text = ""
        clearView.isHidden = true
        collectionView.reloadData()
    }
    
    @IBAction func didTapCancel() {
        searchTextField.endEditing(true)
        viewModel.getBack()
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let count = searchTextField.text?.count ?? 0
        if section == 0 {
            return viewModel.filteredItems.count
        }
//        return count > 0 ? 2: 0
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: PastSearchCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = viewModel.filteredItems[indexPath.item].title
            return cell
        }
        
        let cell: GuideCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        cell.topLine.isHidden = indexPath.item != 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: indexPath.section == 0 ? 48: 129)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header: SearchHeaderCell = collectionView.dequeueReusableSupplementaryView(for: indexPath, kind: UICollectionView.elementKindSectionHeader)
        
        if indexPath.section == 0 {
            header.titleLabel.text = Strings.pastSearches
        }
        
        if indexPath.section == 1 {
            header.titleLabel.text = App.getString(key: "copilotapp.help")
        }
        if kind == UICollectionView.elementKindSectionHeader {
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let count = searchTextField.text?.count ?? 0
        var height: CGFloat = 37
        if section == 0 {
//            height = count > 0 ? 0: 37
            height = 0
        } else {
            height = count > 0 ? 37: 0
        }
        return CGSize(width: collectionView.frame.width - 32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.filteredItems[indexPath.row]
        viewModel.didSelect(item: item)
    }
}

extension SearchViewController: GuideCellDelegate {
    func didTapGo() {
    }
}

extension SearchViewController: SearchViewModelDelegate {
    
}
