//
//  PdfViewerViewController.swift
//  Copilot
//
//  Created by Jamal on 12/13/23.
//

import Foundation
import UIKit
import PDFKit

class PdfViewerViewController: UIViewController {
    
    var viewModel: PdfViewerViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getDocument()
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
        //        viewModel.getBack()
        presentShare()
    }
}

extension PdfViewerViewController: PdfViewerViewModelDelegate {
    
    func loadDocument() {
        let string = "https://www.clickdimensions.com/links/TestPDFfile.pdf"
        guard let url = URL(string: string) else {
            return
        }
        
        //        pdfView.isHidden = true
        //        pdfView.removeFromSuperview()
        //        var webView = UIWebView()
        //        view.addSubview(webView)
        //        webView.align(all: 20)
        //        webView.loadRequest(URLRequest(url: url))
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let document = PDFDocument(url: url) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.pdfView.displayMode = .singlePageContinuous
                    self.pdfView.autoScales = true
                    self.pdfView.displayDirection = .vertical
                    self.pdfView.document = document
                    
                }
            }
        }
    }
    
    @objc private func presentShare() {
        guard let pdfDocument = self.pdfView.document?.dataRepresentation() else { return }
        
        let activity = UIActivityViewController(activityItems: [pdfDocument], applicationActivities: nil)
        present(activity, animated: true)
    }
}
