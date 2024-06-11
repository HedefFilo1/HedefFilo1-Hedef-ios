//
//  ReqFlw1Stp2ViewController.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation
import UIKit

class ReqFlw1Stp2ViewController: UIViewController {
    
    var viewModel: ReqFlw1Stp2ViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        APIService.addUserAction(pageName: "Demands", actionName: "DEMAND_PRODUCT_SERVICE_REQUEST")
#if DEV_DEBUG
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ReqFlw1Stp2Cell.self)
        collectionView.contentInset.top = 20
        applyStyle()
        setTexts()
        createButton.isEnabled = false
    }
    
    func applyStyle() {
        setBasicViews()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24R400)
        descriptionLabel.apply(.custom(.black, .regular, 11))
    }
    
    func setTexts() {
        //        titleLabel.text = Strings.ReqFlw1Stp2
        //        descriptionLabel.text = Strings.ReqFlw1Stp2Description
        titleLabel.text = App.getString(key: "copilotapp.demandproductservice.request.fleet.manager.title")
        descriptionLabel.text = App.getString(key: "copilotapp.demandprocessual.processual.demand.description")
        createButton.setTitle(App.getString(key: "copilotapp.demandproductservice.request.fleet.manager.create.product.request.button"), for: .normal)
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didCreate() {
        viewModel.createTask()
    }
    
}

extension ReqFlw1Stp2ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ReqFlw1Stp2Cell = collectionView.dequeueReusableCell(for: indexPath)
        cell.label.text = viewModel.items[indexPath.item].title
        cell.checkBox.isSelected = viewModel.items[indexPath.item].selected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-48, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ReqFlw1Stp2Cell {
            viewModel.items[indexPath.item].selected = !viewModel.items[indexPath.item].selected
            cell.checkBox.isSelected = viewModel.items[indexPath.item].selected
        }
        
        createButton.isEnabled = viewModel.items.filter({ $0.selected }).count > 0
    }
}

extension ReqFlw1Stp2ViewController: ReqFlw1Stp2ViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
