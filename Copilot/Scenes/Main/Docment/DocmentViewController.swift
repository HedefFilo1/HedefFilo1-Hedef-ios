//
//  DocmentViewController.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import Foundation
import UIKit

class DocumentViewController: UIViewController {
    
    var viewModel: DocumentViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var secondtextLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
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
        titleLabel.apply(.blackS18B700)
        textLabel.apply(.greyS14R400)
        secondtextLabel.apply(.greyS14R400)
        downloadLabel.apply(.themeS16B700)
    }
    
    func setTexts() {
        downloadLabel.text = Strings.download
    }
    
    @IBAction func didTapBack(_ sender: UIButton) {
        viewModel.getBack()
    }
    
    @IBAction func didTapDowndload(_ sender: UIButton) {

    }
}

extension DocumentViewController: DocumentViewModelDelegate {
    
}
