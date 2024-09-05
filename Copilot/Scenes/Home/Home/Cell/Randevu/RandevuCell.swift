//
//  RandevuCell.swift
//  Copilot
//
//  Created by Jamal on 10/11/23.
//

import UIKit

protocol RandevuCellDelegate: AnyObject {
    func didTapOnLocation(lat: Double, lon: Double)
    
}

class RandevuCell: UICollectionViewCell, Reusable {
    
    var appointment: Case? {
        didSet {
            let name = appointment?.supplierName ?? ""
            let title = appointment?.title ?? ""
            randevuLabel.text = "\(name) | \(title)"
            dateLabel.text = appointment?.displayDate
        }
    }
    weak var delegate: RandevuCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var randevuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        applyStyles()
        setTexts()
    }
    
    private func applyStyles() {
        titleLabel.apply(.blackS20B700)
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.borderColor.cgColor
        imageContainer.layer.cornerRadius = 10
        dateLabel.apply(.blackS16B700)
        randevuLabel .apply(.greyS12M500)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.homepage.upcoming.appointment.title")
    }
    
    @IBAction func didTapLocation() {
        if let appointment {
            delegate?.didTapOnLocation(lat: appointment.latitude ?? 0, lon: appointment.longitude ?? 0)
        }
    }
}
