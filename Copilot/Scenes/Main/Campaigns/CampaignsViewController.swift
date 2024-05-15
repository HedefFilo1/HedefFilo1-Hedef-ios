//
//  CampaignsViewController.swift
//  Copilot
//
//  Created by Jamal on 11/6/23.
//

import Foundation
import UIKit

class CampaignsViewController: UIViewController {
    
    var viewModel: CampaignsViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var offerButton: UIButton!
    @IBOutlet weak var newsButton: UIButton!
    @IBOutlet weak var sponsorshipButton: UIButton!
    @IBOutlet var borderViews: [UIView]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var currentTab = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getCampaign()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showTabbarView()
    }
    
    func setupUI() {
        setBasicViews()
        applyStyle()
        setTexts()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CampaignsOfferTabCell.self)
        collectionView.register(cellType: NewsTabCell.self)
        collectionView.register(cellType: SponsorshipTabCell.self)
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
        offerButton.apply(.blackS18R400)
        newsButton.apply(.blackS18R400)
        sponsorshipButton.apply(.blackS18R400)
        for view in borderViews {
            view.backgroundColor = .disabled
        }
        borderViews[0].backgroundColor = .theme
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.campaign.title")
        
        offerButton.setTitle(App.getString(key: "copilotapp.campaign.tab.campaign"), for: .normal)
        newsButton.setTitle(App.getString(key: "copilotapp.campaign.tab.news"), for: .normal)
        sponsorshipButton.setTitle(App.getString(key: "copilotapp.campaign.tab.sponsorship"), for: .normal)
    }
    
    @IBAction func didTab(_ sender: UIView) {
        let tag = sender.tag
        if tag == currentTab {
            return
        }
        
        APIService.addUserAction(pageName: "Campaigns", actionName: "CAMPAIGN_TAB_CLICK")
        if tag == 0 {
            APIService.addUserAction(pageName: "Campaigns", actionName: "CAMPAIGN_BENEFIT_CAMPAIGN")
        }
        if tag == 1 {
            APIService.addUserAction(pageName: "Campaigns", actionName: "CAMPAIGN_NEWS_TAB_CLICK")
        }
        
        if tag == 2 {
            APIService.addUserAction(pageName: "Campaigns", actionName: "CAMPAIGN_SPONSORSHIP_TAB_CLICK")
        }
        
        borderViews[currentTab].backgroundColor = .disabled
        currentTab = tag
        borderViews[tag].backgroundColor = .theme
        collectionView.scrollToItem(at: IndexPath(row: 0, section: tag), at: .centeredHorizontally, animated: true)
    }
}

extension CampaignsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: CampaignsOfferTabCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.items = viewModel.campaigns
            return cell
            
        case 1:
            let cell: NewsTabCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.items = viewModel.news
            return cell
            
        case 2:
            let cell: SponsorshipTabCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.items = viewModel.sponserships
            cell.delegate = self
            return cell
            
        default:
            let cell: CampaignsOfferTabCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
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

extension CampaignsViewController: CampaignsTabCellDelegate {
    func didSelectItem(campaign: Campaign) {
        
        APIService.addUserAction(pageName: "Campaigns", actionName: "CAMPAIGN_GO_DETAIL")
        viewModel.goToCampaignDetail(campaign: campaign)
    }
}

extension CampaignsViewController: CampaignsViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
