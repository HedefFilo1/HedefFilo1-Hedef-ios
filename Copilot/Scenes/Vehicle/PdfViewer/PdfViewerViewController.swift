//
//  PdfViewerViewController.swift
//  Copilot
//
//  Created by Jamal on 12/13/23.
//

import Foundation
import UIKit
import WebKit
import PDFKit

class PdfViewerViewController: UIViewController {
    
    var viewModel: PdfViewerViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDocument()
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
    }
    
    func setTexts() {
        titleLabel.text = Strings.vehicleGuide
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
}

extension PdfViewerViewController: PdfViewerViewModelDelegate {
    
    func loadDocument() {
        let string = CodeStrings.vehicleGuidPdfUrl
        guard let url = URL(string: string) else {
            return
        }
        let webView = UIWebView()
        container.addSubview(webView)
        webView.frame = container.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.backgroundColor = .gray
        webView.clipsToBounds = true
        webView.delegate = self
        webView.loadRequest(URLRequest(url: url))
    }
}

extension PdfViewerViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadingLabel.isHidden = true
    }
}
