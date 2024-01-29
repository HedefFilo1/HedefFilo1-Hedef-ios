//
//  LastikOperationsViewController.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation
import UIKit

class TireOperationsViewController: UIViewController {
    
    var viewModel: TireOperationsViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getTire()
        
#if DEV_DEBUG
                if let coordintor = viewModel.coordinatorDelegate as? TireCoordinator {
//                    coordintor.goToServiceDetail(service: Supplier(id: "e3", name: "Boch SErvice", address: "Marawa", lon: "", lat: "", district: "", city: "", phone: ""))
                    coordintor.goToServiceDetail(service: nil, appointment: nil, tireSupportType: .newWinter)
//                    coordintor.goToLastikOperations(appointment: nil)
                }
        
#endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        setBasicViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: LastikRandevuCell.self)
        collectionView.register(cellType: LastikOperationButtonsCell.self)
        collectionView.contentInset.top = 12
        collectionView.contentInset.bottom = 90
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 40
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleLabel.apply(.blackS24B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.tireOperations
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension TireOperationsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.appointment == nil ? 0: 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: LastikRandevuCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.appointment = viewModel.appointment
            cell.tire = viewModel.tire
            return cell
        }
        
        let cell: LastikOperationButtonsCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
//        cell.shouldRemoveNewButton = viewModel.appointment != nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 353
        
        if indexPath.section == 1 {
            height = viewModel.appointment == nil ? (collectionView.frame.height - 90): 184
        }
        return CGSize(width: collectionView.frame.width-32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension TireOperationsViewController: LastikRandevuCellDelegate, LastikOperationButtonsCellDelegate {
    
    func didTapEdit() {
        viewModel.goToServiceDetail()
    }
    
    func goToRequestNewLastik() {
        viewModel.goToRequestNewLastik()
    }
    
    func goToLastikRandevu() {
        viewModel.goToFlow3Step2Damage()
    }
    
    func didTapChange() {
        viewModel.goToFlow5Step2TireChange()
    }
}

extension TireOperationsViewController: TireOperationsViewModelDelegate {
    func setTire() {
        collectionView.reloadData()
    }
}
