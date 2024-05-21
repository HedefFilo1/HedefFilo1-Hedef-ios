//
//  SupportGuideDetailViewController.swift
//  Copilot
//
//  Created by Jamal on 3/20/24.
//

import Foundation
import UIKit

class SupportGuideDetailViewController: UIViewController {
    
    var viewModel: SupportGuideDetailViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        textlabel.text = viewModel.item?.description ?? ""
        imageView.loadImageFrom(url: viewModel.item?.imageFile)
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        textlabel.apply(.greyS14R400)
        downloadLabel.apply(.themeS16B700)
    }
    
    func setTexts() {
        titleLabel.text = viewModel.item?.title
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapDowndload(_ sender: UIButton) {
        let stringURL = viewModel.item?.documentFile ?? ""
        if let url = URL(string: stringURL) {
            print(url.absoluteString)
            showShareView(url: url)
        }
    }
    
    func showShareView(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}

extension SupportGuideDetailViewController: SupportGuideDetailViewModelDelegate {
   
}
