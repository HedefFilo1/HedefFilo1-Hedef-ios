//
//  DocumentPopupViewController.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import Foundation
import UIKit

class DocumentPopupViewController: SheetViewController {
    
    var viewModel: DocumentPopupViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 344
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cancelButton: CPLightButton!
    @IBOutlet weak var deleteButton: CPButton!
    @IBOutlet weak var loadingContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        deleteButton.isEnabled = true
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        descriptionLabel.apply(.greyS14R400)
    }
    
    func setTexts() {
        titleLabel.text = Strings.docDeleteTitle
        cancelButton.setTitle(Strings.cancel, for: .normal)
        deleteButton.setTitle(Strings.delete, for: .normal)
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        viewModel.dismiss()
    }
    
    @IBAction func didTapCancel(_ sender: UIButton) {
        viewModel.dismiss()
    }
    
    @IBAction func didTapDelete(_ sender: UIButton) {
        viewModel.deleteAndDismiss()
    }
}

extension DocumentPopupViewController: DocumentPopupViewModelDelegate {
    
}
