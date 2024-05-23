//
//  WarningGuideViewController.swift
//  Copilot
//
//  Created by Jamal on 5/23/24.
//

import Foundation
import UIKit

class WarningGuideViewController: UIViewController {
    
    var viewModel: WarningGuideViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var breakdownPageButton: CPLightButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
#if DEV_DEBUG
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: WarningGuideCell.self)
        collectionView.contentInset.bottom = 10
        collectionView.contentInset.left = 24
        collectionView.contentInset.right = 24
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.breakdownWarningLightGuide
        breakdownPageButton.setTitle(Strings.returnToBreakdownPage, for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapBreakdownPage() {
        viewModel.getBackToBreakdown()
    }
}

extension WarningGuideViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.guides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WarningGuideCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.titleLabel.text = viewModel.guides[indexPath.item].title
        cell.imageView.image = UIImage(named: viewModel.guides[indexPath.item].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension WarningGuideViewController: WarningGuideVMDelegate {
    
}
