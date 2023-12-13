//
//  TabBarView.swift
//  Copilot
//
//  Created by Jamal on 10/12/23.
//

import Foundation
import UIKit

protocol TabBarViewDelegate: AnyObject {
    func didSelect(tab: Int)
    func didTapMenu()
}

class TabBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    weak var delegate: TabBarViewDelegate?
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var imagesViews: [UIImageView]!
    @IBOutlet var labels: [UILabel]!
    
    private var last = 0
    
    private var nibName: String {
        return String(describing: type(of: self))
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        
        applyStyles()
        changeTab(index: 2)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func applyStyles() {
        boxShadow(xValue: 0, yValue: -15, radius: 25, color: .black, opacity: 0.05)
        contentView.layer.cornerRadius = 27
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        
        for label in labels {
            label.apply(.greyS12R400)
        }
    }
    
    @IBAction func didTab(_ sender: UIView) {
        let tag = sender.tag
        delegate?.didSelect(tab: tag)
        changeTab(index: tag)
    }
    
    @IBAction func didTabMenu(_ sender: UIView) {
        delegate?.didSelect(tab: 4)
        changeTab(index: 4)
    }
    
    func changeTab(index: Int) {
        changeUnSelectedIndexImage(index: last)
        labels[last].apply(.greyS12R400)
        last = index
        labels[last].apply(.secondRed(.r400, size: 12))
        changeSelectedIndexImage(index: last)
    }
    
    func changeUnSelectedIndexImage(index: Int) {
        switch index {
        case 0:
            imagesViews[0].image = Images.carTabIcon
            
        case 1:
            imagesViews[1].image = Images.toolIcon
            
        case 2:
            imagesViews[2].image = Images.homeTab
            
        case 3:
            imagesViews[3].image = Images.helpIcon
            
        case 4:
            imagesViews[4].image = Images.moreTabIcon
            
        default:
            break
        }
    }
    
    func changeSelectedIndexImage(index: Int) {
        switch index {
        case 0:
            imagesViews[0].image = Images.carTabSelectedIcon
            
        case 1:
            imagesViews[1].image = Images.toolSelectedIcon
            
        case 2:
            imagesViews[2].image = Images.homeSelectedTab
            
        case 3:
            imagesViews[3].image = Images.helpSelectedIcon
            
        case 4:
            imagesViews[4].image = Images.moreTabSelectedIcon
            
        default:
            break
        }
    }
    
    func deselectLastIndex() {
        labels[last].apply(.greyS12R400)
        changeUnSelectedIndexImage(index: last)
    }
    
}
