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
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var downloadLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if viewModel.document != nil {
            loadingLabel.isHidden = true
            viewModel.getDocument()
        } else {
            loadDocument()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabbarView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabbarView()
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        downloadLabel.apply(.themeS16B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.vehicleGuide
        if let title = viewModel.document?.name {
            titleLabel.text = title
        }
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
    @IBAction func didTapDowndload(_ sender: UIButton) {
        viewModel.downloadDoc()
    }
}

extension PdfViewerViewController: PdfViewerViewModelDelegate {
    
    func showShareView(url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    func loadDocument() {
        let string = CodeStrings.vehicleGuidPdfUrl
        guard let url = URL(string: string) else {
            return
        }
        let webView = WKWebView()
        container.addSubview(webView)
        webView.frame = container.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        webView.backgroundColor = .gray
        webView.clipsToBounds = true
        webView.load(URLRequest(url: url))
        downloadView.isHidden = true
    }
    
    func setDocument() {
        guard let content = viewModel.conetent,
        let data = Data(base64Encoded: content.content) else {
            loadingLabel.isHidden = false
            loadingLabel.text = "No Data for document."
            return
        }
        let pdfView = PDFView()
        container.addSubview(pdfView)
        pdfView.frame = container.bounds
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        pdfView.backgroundColor = .gray
        pdfView.clipsToBounds = true
        pdfView.autoScales = true
        pdfView.displayDirection = .vertical
        
        let document = PDFDocument(data: data)
        pdfView.document = document
    }
}