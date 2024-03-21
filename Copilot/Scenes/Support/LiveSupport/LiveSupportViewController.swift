//
//  LiveSupportViewController.swift
//  Copilot
//
//  Created by Jamal on 3/22/24.
//

import Foundation
import UIKit

class LiveSupportViewController: UIViewController {
    
    var viewModel: LiveSupportViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var headsetView: UIView!
    @IBOutlet weak var headsetImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendView: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideTabbarView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        headsetView.layer.cornerRadius = 40
        headsetImageView.image = headsetImageView.image?.withRenderingMode(.alwaysTemplate)
        headsetImageView.tintColor = .theme
        userLabel.apply(.blackS18B700)
        statusLabel.apply(.custom(.textSuccess, .bold, 12))
        textFieldView.layer.cornerRadius = 10
        textFieldView.layer.borderWidth = 1
        textFieldView.layer.borderColor = UIColor.borderColor.cgColor
        sendView.layer.cornerRadius = 10
        textField.borderStyle = .none
    }
    
    func setTexts() {
//        titleLabel.text =
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapSend() {
        
    }
    
    @IBAction func didTapAttach() {
        
    }
}

extension LiveSupportViewController: LiveSupportViewModelDelegate {
   
}
