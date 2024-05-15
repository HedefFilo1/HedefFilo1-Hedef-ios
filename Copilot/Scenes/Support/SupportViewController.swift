//
//  SupportViewController.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.03.2024.
//

import UIKit

class SupportViewController: UIViewController {

    // MARK: - IBOutlets
    // MARK: - UIViews
    @IBOutlet weak var contentView: UIView!
    // MARK: - UILabels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    // MARK: - UIButtons
    @IBOutlet weak var callHelpCenterButton: UIButton!
    
    // MARK: - UICollectionView
    @IBOutlet weak var menuListCollectionView: UICollectionView!

    // MARK: - ViewModel
    var viewModel: SupportViewModelType! {
        didSet {
            viewModel.viewDelegate = self
        }
    }

    // MARK: Lifecylce Methods
    deinit {
        viewModel.finish()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        viewModel.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabbarView()
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
        menuListCollectionView.register(cellType: SupportMenuItemCollectionViewCell.self)
        menuListCollectionView.delegate = self
        menuListCollectionView.dataSource = self
        menuListCollectionView.contentInset.top = 20
        menuListCollectionView.contentInset.bottom = 60
    }

    private func applyStyles() {
        titleLabel.apply(.blackS24R400)
        descriptionLabel.apply(.custom(.black, .regular, 11.0))
        callHelpCenterButton.apply(.custom(.white, .regular, 16.0))
    }

    private func configure() {
        titleLabel.text = App.getString(key: "copilotapp.help")
        descriptionLabel.text = Strings.supportDescription
        callHelpCenterButton.setTitle(App.getString(key: "copilotapp.help.button"), for: .normal)
    }

    @IBAction func didTapLiveSupport() {
        APIService.addUserAction(pageName: "Help", actionName: "HELP_WEBCHAT")
        viewModel.goToLiveSupport()
    }
    
    @IBAction func didTapCall() {
        APIService.addUserAction(pageName: "Help", actionName: "HELP_CALL_SOLUTION_CENTER")
        guard let url = URL(string: CodeStrings.callSupportCenterPhone) else {
        return
        }
        UIApplication.shared.open(url)
    }
}

extension SupportViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SupportMenuItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let titleText = viewModel.title(for: indexPath.item)
        cell.configure(titleText: titleText)
        return cell
    }
}

extension SupportViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            viewModel.goToSupportGuide()
        case 1:
            viewModel.goToFeedback()
        case 2:
            viewModel.goToFAQ()
        default:
            break
        }
    }
}

extension SupportViewController: UICollectionViewDelegateFlowLayout {
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

extension SupportViewController: SupportViewModelViewDelegate {

}
