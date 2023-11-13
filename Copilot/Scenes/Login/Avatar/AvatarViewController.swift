//
//  AvatarViewController.swift
//  Copilot
//
//  Created by Jamal on 11/13/23.
//

import Foundation
import UIKit

class AvatarViewController: UIViewController {
    
    var viewModel: AvatarViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectButton: CPButton!
    
    private var selectedIndex: Int?
    
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
        setBasicViews(addNotfication: false, addSearch: false)
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: AvatarCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 24, bottom: 12, right: 24)
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS20B700)
        descriptionLabel.apply(.greyS12R400)
        selectButton.isSmallFontSize = true
    }
    
    func setTexts() {
        titleLabel.text = Strings.selectYourAvatar
        descriptionLabel.text = Strings.selectAvatarDescription
        selectButton.setTitle(Strings.select, for: .normal)
    }
    
    @IBAction func didTapSelect() {
        viewModel.selectAvatar()
    }
}

extension AvatarViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: AvatarCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.item = viewModel.avatars?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectButton.isEnabled = true
        if let index = selectedIndex, let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? AvatarCell {
            cell.radioBox.isSelected = false
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AvatarCell {
            cell.radioBox.isSelected = true
            selectedIndex = indexPath.item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 48 - 20)/2)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension AvatarViewController: AvatarViewModelDelegate {
    
}
