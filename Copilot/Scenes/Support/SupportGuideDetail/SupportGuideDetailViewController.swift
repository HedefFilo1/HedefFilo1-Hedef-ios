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
        //        downloadFile(with: "")
    }
    
    //    func downloadFile(with url: String) {
    //        let stringURL = viewModel.item?.documentFile ?? ""
    //        guard let url = URL(string: stringURL) else { return }
    //
    //        let downloadSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    //
    //        let downloadTask = downloadSession.downloadTask(with: url)
    //        Loading.shared.show()
    //        downloadTask.resume()
    //
    //    }
    
    //    func downloadData(url: URL) async -> Data? {
    //        do {
    //            let (data, _) = try await URLSession.shared.data(from: url)
    //            return data
    //        } catch let error {
    //            print(error)
    //        }
    //        return nil
    //    }
    
    //    func showShareView(urli: URL) {
    //        let activityViewController = UIActivityViewController(activityItems: [urli], applicationActivities: nil)
    //        present(activityViewController, animated: true, completion: nil)
    //    }
    
    func showShareView(url: URL) {
        Loading.shared.show()
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                Loading.shared.hide()
                let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
}

extension SupportGuideDetailViewController: SupportGuideDetailViewModelDelegate {
    
}
// extension SupportGuideDetailViewController: URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//
//        // create destination URL with the original pdf name
//        guard let url = downloadTask.originalRequest?.url else { return }
//        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
//        // delete original copy
//        try? FileManager.default.removeItem(at: destinationURL)
//        // copy from temp to Document
//        do {
//            try FileManager.default.copyItem(at: location, to: destinationURL)
//            //             destinationURL
//            DispatchQueue.main.async {
//                Loading.shared.hide()
//                self.showShareView(url: location)
//            }
//
//        } catch let error {
//            print("Copy Error: \(error.localizedDescription)")
//        }
//    }
// }
