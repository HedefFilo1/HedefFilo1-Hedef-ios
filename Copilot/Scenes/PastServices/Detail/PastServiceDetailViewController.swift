//
//  PastServiceDetailViewController.swift
//  Copilot
//
//  Created by Jamal on 4/5/24.
//

import Foundation
import UIKit

class PastServiceDetailViewController: UIViewController {
    
    var viewModel: PastServiceDetailViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var servicesButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: PastServiceDetailCell.self)
        collectionView.contentInset.top = 8
        collectionView.contentInset.bottom = 20
        servicesButton.isEnabled = true
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = "\(viewModel.title) \(Strings.detail)"
        servicesButton.setTitle(Strings.pastServiceTransactions, for: .normal)
    }
    
    @IBAction func didTabButton(_ sender: UIView) {
        viewModel.getBack()
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension PastServiceDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: PastServiceDetailCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.item = viewModel.service
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 384
            
        case 1:
            height = 80
     
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

extension PastServiceDetailViewController: PastServiceDetailViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
