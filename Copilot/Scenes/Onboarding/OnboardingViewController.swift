//
//  OnboardingViewController.swift
//  Copilot
//
//  Created by Jamal on 9/28/23.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    
    var viewModel: OnboardingViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var scrollingView: ScrollTouchHandler!
    @IBOutlet var indexViews: [UIView]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: CPLightButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backContainer: UIView!
    @IBOutlet weak var membershipView: UIView!
    @IBOutlet weak var notMemberLabel: UILabel!
    @IBOutlet weak var becomeMemberButton: UIButton!
    
    private var xOffset: CGFloat = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupUI()
//        setIndexContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Persistence.onboardingHasShown = true
        if App.appLoaded == false {
            App.appLoaded = true
        }
        
    }
    
    private func setupUI() {
        scrollingView.delegate = self
        setupCollectionView()
        applyStyles()
        setTexts()
        backContainer.widthConstraint?.constant = 0
        membershipView.isHidden = true
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(cellType: OnboardingCell.self)
        collectionView.backgroundColor = .clear
    }
    
    private func applyStyles() {
        view.backgroundColor = .theme
        sheetView.layer.cornerRadius = 35
        sheetView.backgroundColor = .white
        sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        for view in indexViews {
            view.layer.cornerRadius = 2
            view.backgroundColor = .appLightGrey
        }
        
        indexViews[viewModel.currentIndex].widthConstraint?.constant = 32
        indexViews[viewModel.currentIndex].backgroundColor = .appRed
        
        titleLabel.apply(.blackS20B700)
        descriptionLabel.apply(.greyS12R400)
        
        backView.layer.cornerRadius = 10
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.textGrey.cgColor
        skipButton.apply(.greyS16R400)
        notMemberLabel.apply(.greyS16R400)
        becomeMemberButton.apply(.themeS16B700)
    }
    
    func setTexts() {
        nextButton.setTitle(App.getString(key: "copilotapp.onboarding.button"), for: .normal)
        skipButton.setAttributedTitle(App.getString(key: "copilotapp.onboarding.bottom.button")?.underLined, for: .normal)
        notMemberLabel.text = App.getString(key: "copilotapp.onboarding.four.bottom.description")
        
        becomeMemberButton.setAttributedTitle(App.getString(key: "copilotapp.onboarding.four.bottom.button")?.underLined, for: .normal)
        titleLabel.text = App.getString(key: "copilotapp.onboarding.one.title")
        descriptionLabel.text = App.getString(key: "copilotapp.onboarding.one.description")
    }
    
    @IBAction func didTapNextButton() {
        let next = viewModel.currentIndex + 1
        if next > 3 {
            viewModel.goToNextScene()
            return
        }
        collectionView.scrollToItem(at: IndexPath(row: next, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func didTapSkipButton() {
        collectionView.scrollToItem(at: IndexPath(row: 3, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func didTapBackButton() {
        var prev = viewModel.currentIndex - 1
        if prev < 0 {
            prev = 0
        }
        collectionView.scrollToItem(at: IndexPath(row: prev, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func setIndexContent() {
        
        nextButton.setTitle(App.getString(key: "copilotapp.onboarding.button"), for: .normal)
        nextButton.backgroundColor = .white
        nextButton.setTitleColor(.theme, for: .normal)
        skipButton.setAttributedTitle(App.getString(key: "copilotapp.onboarding.bottom.button")?.underLined, for: .normal)
        skipButton.isHidden = false
        membershipView.isHidden = true
        
        if viewModel.currentIndex == 0 {
            backContainer.widthConstraint?.constant = 0
            titleLabel.text = App.getString(key: "copilotapp.onboarding.one.title")
            descriptionLabel.text = App.getString(key: "copilotapp.onboarding.one.description")
            return
        }
        
        backContainer.widthConstraint?.constant = 66
        if viewModel.currentIndex == 1 {
            titleLabel.text = App.getString(key: "copilotapp.onboarding.two.title")
            descriptionLabel.text = App.getString(key: "copilotapp.onboarding.two.description")
            return
        }
        
        if viewModel.currentIndex == 2 {
            titleLabel.text = App.getString(key: "copilotapp.onboarding.three.title")
            descriptionLabel.text = App.getString(key: "copilotapp.onboarding.three.description")
            return
        }
        
        if viewModel.currentIndex == 3 {
            
            titleLabel.text = App.getString(key: "copilotapp.onboarding.four.title")
            descriptionLabel.text = App.getString(key: "copilotapp.onboarding.four.description")
            nextButton.setTitle(App.getString(key: "copilotapp.onboarding.four.title"), for: .normal)
            nextButton.backgroundColor = .theme
            nextButton.setTitleColor(.white, for: .normal)
            skipButton.setTitle(App.getString(key: "copilotapp.onboarding.four.bottom.description"), for: .normal)
            skipButton.isHidden = true
            membershipView.isHidden = false
            return
        }
    }
    
    @IBAction func didTapBecomMemberButton() {
        viewModel.goToSignup()
    }
    
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnboardingCell = collectionView.dequeueReusableCell(for: indexPath)
        switch indexPath.item {
        case 0:
            cell.imageView.image = Images.onboarding1
            
        case 1:
            cell.imageView.image = Images.onboarding2
            
        case 2:
            cell.imageView.image = Images.onboarding3
            
        case 3:
            cell.imageView.image = Images.onboarding4
            
        default:
            break
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let idx = Int(collectionView.contentOffset.x / collectionView.frame.size.width)
        
        if idx == viewModel.currentIndex || idx < 0 || idx > 3 { return }
        
        indexViews[viewModel.currentIndex].widthConstraint?.constant = 4
        indexViews[viewModel.currentIndex].backgroundColor = .appLightGrey
        
        viewModel.currentIndex = idx
        
        indexViews[viewModel.currentIndex].widthConstraint?.constant = 32
        indexViews[viewModel.currentIndex].backgroundColor = .appRed
        setIndexContent()
    }
    
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension OnboardingViewController: ScrollTouchHandlerDelegate {
    
    func viewForScroll() -> UIScrollView {
        return collectionView
    }
}

extension OnboardingViewController: OnboardingViewModelDelegate {
    
}
