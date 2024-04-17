//
//  FeedbackViewController.swift
//  Copilot
//
//  Created by Jamal on 3/21/24.
//

import Foundation
import UIKit

class FeedbackViewController: UIViewController {

    // MARK: - IBOutlets
    // MARK: - UIViews
    @IBOutlet weak var contentView: UIView!
    // MARK: - UILabels
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - UIButtons
    @IBOutlet weak var callHelpCenterButton: UIButton!
    
    // MARK: - UICollectionView
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - ViewModel
    var viewModel: FeedbackViewModelType! {
        didSet {
            viewModel.viewDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        callHelpCenterButton.layer.cornerRadius = 10
        setupCollectionView()
        setBasicViews()
        applyStyles()
    }
    
    private func setupCollectionView() {
        collectionView.register(cellType: FeedbackCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.top = 20
        collectionView.contentInset.bottom = 60
    }

    private func applyStyles() {
        titleLabel.apply(.blackS24B700)
        callHelpCenterButton.apply(.custom(.white, .regular, 16.0))
    }

    private func configure() {
        titleLabel.text = Strings.supportFeedbackMenuTitle
    }
    
    @IBAction func didTapCall() {
        guard let url = URL(string: CodeStrings.callSupportCenterPhone) else {
        return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }

}

extension FeedbackViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FeedbackCell = collectionView.dequeueReusableCell(for: indexPath)
        let titleText = viewModel.items[indexPath.item].title
        cell.configure(titleText: titleText)
        return cell
    }
}

extension FeedbackViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            APIService.addUserAction(pageName: "Help", actionName: "HELP_FEEDBACK_PROCESS_REQUEST")
            viewModel.goToProccessRequests()
           
        case 1:
            APIService.addUserAction(pageName: "Help", actionName: "HELP_FEEDBACK_SERVICE OPERATION")
            viewModel.goToServiceOperations()
        default:
            break
        }
    }
}

extension FeedbackViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 48, height: 57)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension FeedbackViewController: FeedbackViewModelViewDelegate {

}
