//
//  DocumentCell.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import UIKit

protocol DocumentCellDelegate: AnyObject {
    func didTapDelete(item: Document)
    func didTapDownload(item: Document)
}

class DocumentCell: UICollectionViewCell, Reusable {
    
    var item: Document? {
        didSet {
            titleLabel.text = item?.name
        }
    }
    weak var delegate: DocumentCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
    }
    
    private func applyStyles() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        titleLabel.apply(.blackS14B700)
        downloadLabel.apply(.themeS12B700)
    }
    
    func setTexts() {
        downloadLabel.text = Strings.download
    }
    
    @IBAction func didTapDownload() {
        if let item = item {
            delegate?.didTapDownload(item: item)
        }
    }
}
