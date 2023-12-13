//
//  DocumentCell.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import UIKit

protocol DocumentCellDelegate: AnyObject {
    func didTapDelete(item: MockDocument)
    func didTapDownload()
}

class DocumentCell: UICollectionViewCell, Reusable {
    
    var item: MockDocument? {
        didSet {
            titleLabel.text = item?.title
            dateLabel.text = item?.date
        }
    }
    weak var delegate: DocumentCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteLabel: UILabel!
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
        dateLabel.apply(.greyS14R400)
        deleteLabel.apply(.themeS12B700)
        downloadLabel.apply(.themeS12B700)
    }
    
    func setTexts() {
        deleteLabel.text = Strings.delete
        downloadLabel.text = Strings.download
    }
    
    @IBAction func didTapDelete() {
        if let item = item {
            delegate?.didTapDelete(item: item)
        }
    }
    
    @IBAction func didTapDownload() {
        delegate?.didTapDownload()
    }
}
