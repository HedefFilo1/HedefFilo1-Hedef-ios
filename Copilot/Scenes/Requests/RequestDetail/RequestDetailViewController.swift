//
//  RequestDetailViewController.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import Foundation
import UIKit

class RequestDetailViewController: UIViewController {
    
    var viewModel: RequestDetailViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var addationalLabel: UILabel!
    @IBOutlet weak var addationalTextLabel: UILabel!
    @IBOutlet weak var cancelButton: CPButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTask()
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        cancelButton.isEnabled = true
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18R400)
        imageView.layer.cornerRadius = 10
        
        statusLabel.apply(.blackS14R400)
        statusView.layer.cornerRadius = 10
        statusValueLabel.apply(.custom(.white, .regular, 12))
        
        descriptionLabel.apply(.blackS14R400)
        descriptionTextLabel.apply(.greyS12R400)
        
        addationalLabel.apply(.blackS14R400)
        addationalTextLabel.apply(.greyS12R400)
    }
    
    func setTexts() {
        statusLabel.text =  App.getString(key: "copilotapp.demandlist.demand.status")
        descriptionLabel.text = App.getString(key: "copilotapp.demandlist.explanation")
        addationalLabel.text = App.getString(key: "copilotapp.demandlist.additional.info")
        cancelButton.setTitle(App.getString(key: "copilotapp.demandlist.cancel.request.button"), for: .normal)
        
    }
    
    func setTask() {
        guard let item = viewModel.item else { return }
        titleLabel.text = item.subjectResult
        if let text = item.statusTextResult {
            statusView.backgroundColor = item.status.color
            statusValueLabel.text = text
        } else {
            statusView.backgroundColor = .clear
            statusValueLabel.text = ""
        }
        descriptionTextLabel.text = item.additionalInfo
        addationalTextLabel.text = item.description
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapCancel() {
        APIService.addUserAction(pageName: "Demands", actionName: "DEMAND_DEMAND_LIST_PRODUCT_SERVICE_REQUEST_REQUEST_CANCEL")
        viewModel.cancelTask()
    }
}

extension RequestDetailViewController: RequestDetailViewModelDelegate {
    
}
