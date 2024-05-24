//
//  LiveSupportViewController.swift
//  Copilot
//
//  Created by Jamal on 3/22/24.
//

import Foundation
import UIKit
import WebKit

class LiveSupportViewController: UIViewController {
    
    var viewModel: LiveSupportViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideTabbarView()
        viewModel.getLiveSupport()
        APIService.addUserAction(pageName: "Help", actionName: "HELP_WEBCHAT")
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
     
    }
    
    func setTexts() {
//        titleLabel.text =
    }
    
    @IBAction func didTapBack() {
        viewModel.getBack()
    }
    
}

extension LiveSupportViewController: LiveSupportViewModelDelegate {
    func loadWebView() {
        guard let string = viewModel.model?.url else { return }
                
        guard let url = URL(string: string) else {
            return
        }
        let webView = WKWebView()
        container.addSubview(webView)
        webView.frame = container.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

//        let post: String = "sourceId=44574fdsf01e-e4da-4e8c-a897-17722d00e1fe&sourceType=abc"
//        let postData: Data = post.data(using: String.Encoding.ascii, allowLossyConversion: true)!

//        request.httpBody = postData
        webView.load(request)
//        webView.load
    }
}
