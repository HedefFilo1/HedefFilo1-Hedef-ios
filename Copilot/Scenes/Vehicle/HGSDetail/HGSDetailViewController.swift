//
//  HGSDetailViewController.swift
//  Copilot
//
//  Created by Jamal on 11/28/23.
//

import Foundation
import UIKit

class HGSDetailViewController: UIViewController {
    
    var viewModel: HGSDetailViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var fieldLabels: [UILabel]!
    @IBOutlet var valueLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        backImageView.image = backImageView.image?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = .lightBlack
        for label in fieldLabels {
            label.apply(.greyS14R400)
        }
        
        for label in valueLabels {
            label.apply(.blackS14B700)
        }
    }
    
    func setTexts() {
        
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
    
    @IBAction func didTapDowndload(_ sender: UIButton) {

    }
}

extension HGSDetailViewController: HGSDetailViewModelDelegate {
    
}
