//
//  CPDropDownList.swift
//  Copilot
//
//  Created by Jamal on 12/29/23.
//

import Foundation
import UIKit

protocol CPDropDownListDelegate: AnyObject {
    func superViewForDropDown(in dropDownList: CPDropDownList) -> UIView?
    func numberOfItems(in dropDownList: CPDropDownList) -> Int
    func CPDropDownList(_ dropDownList: CPDropDownList, titleFor index: Int) -> String
    func CPDropDownList(_ dropDownList: CPDropDownList, didSelect index: Int)
    func willOpen(_ dropDownList: CPDropDownList)
    func willDismiss(_ dropDownList: CPDropDownList)
    func didDismiss(_ dropDownList: CPDropDownList)
    func CPDropDownList(_ dropDownList: CPDropDownList, shouldSelect index: Int) -> Bool
}

class CPDropDownList: UIView {
    
    var selectedIndex: Int?
    var isOpen = false
    var maxHeight: CGFloat = 223
    weak var owner: UIView?
    
    var itemHeight: CGFloat = 43
    var animateDuration: CGFloat = 0.2
    private var hasDropDownAdded = false
    
    let headView = UIView()
    private let titleLabel = UILabel()
    let valueLabel = UILabel()
    private let chevronImageView = UIImageView()
    var titleLabelTop: NSLayoutConstraint?
    private let bottomBorderView = UIView()
    private let dropDownView = UIView()
    let tableView = UITableView()
    
    private var superViewForDropDown: UIView? {
        if let view = delegate?.superViewForDropDown(in: self) {
            return view
        } else {
            return superview
        }
    }
    
    var title: String = "title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    weak var delegate: CPDropDownListDelegate? {
        didSet {
            
        }
    }
    
    var hasSelectedItem: Bool {
        return selectedIndex != nil
    }
    
    var scrollIndicatorInsets: UIEdgeInsets? {
        didSet {
            if let insets = scrollIndicatorInsets {
                tableView.scrollIndicatorInsets = insets
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reload()
    }
    
    func setup() {
        backgroundColor = .clear
        setHeadView()
        setChevron()
        setTitleLabel()
        setValueLabel()
        setBorder()
        
    }
    
    private func setHeadView() {
        addSubviews(views: headView)
        headView.align(top: 0, leading: 0, trailing: 0, height: 50)
        headView.backgroundColor = .white.withAlphaComponent(0.9)
        headView.layer.cornerRadius = 10
        headView.layer.borderColor = UIColor.borderColor.cgColor
//        headView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        headView.addGestureRecognizer(tapGesture)
    }
    
    private func setChevron() {
        addSubview(chevronImageView)
        let image = Images.chevronBlackDown.withRenderingMode(.alwaysTemplate)
        chevronImageView.image = image
        chevronImageView.tintColor = .black
        chevronImageView.align(trailing: 16, widthAndHeight: 24, centerY: 0)
        chevronImageView.transform = CGAffineTransform(rotationAngle: 2 * .pi)
    }
    
    private func setTitleLabel() {
        headView.addSubview(titleLabel)
        titleLabel.text = ""
        titleLabel.align(leading: 16)
        titleLabel.align(toView: chevronImageView, lessThanOrEqualTraling: 10)
        titleLabelTop = titleLabel.topAnchor.constraint(equalTo: headView.topAnchor, constant: 8)
        titleLabelTop?.isActive = true
        titleLabel.apply(TextStyle(fontStyle: .regular, size: 12), color: .fieldsTitle)
    }
    
    private func setValueLabel() {
        headView.addSubview(valueLabel)
        valueLabel.align(top: 25, leading: 16)
        valueLabel.align(toView: chevronImageView, lessThanOrEqualTraling: 10)
        valueLabel.apply(TextStyle(fontStyle: .regular, size: 12), color: .fieldsTitle)
    }
    
    private func setBorder() {
//        headView.addSubview(bottomBorderView)
//        bottomBorderView.align(bottom: 0, height: 2, leadingAndTrailing: 0)
//        bottomBorderView.backgroundColor = .theme
//        bottomBorderView.isHidden = true
        headView.layer.borderWidth = 1
        headView.layer.borderColor = UIColor.borderColor.cgColor
    }
    
    private func setDropDownView() {
        if hasDropDownAdded { return }
        
        if let view = delegate?.superViewForDropDown(in: self) {
            view.addSubview(dropDownView)
        } else {
            superview?.addSubview(dropDownView)
        }
        dropDownView.clipsToBounds = false
        dropDownView.align(toView: headView, height: 8, leadingAndTrailing: 0, topToBottom: 0)
        hasDropDownAdded = true
        setTableView()
    }
    
    func setDefaultStyles() {
        bottomBorderView.isHidden = true
        titleLabel.textColor = .black
        chevronImageView.tintColor = .black
        titleLabel.apply(TextStyle(fontStyle: .regular, size: 12), color: .textGrey)
    }
    
    func setSelectedStyles() {
        titleLabel.apply(TextStyle(fontStyle: .regular, size: 12), color: .textGrey)
        chevronImageView.tintColor = .black
        bottomBorderView.isHidden = false
    }
    
    func setOpenedStyles() {
        bottomBorderView.isHidden = false
        titleLabel.textColor = .textGrey
        chevronImageView.tintColor = .black
        headView.layer.borderColor = UIColor.borderColor.cgColor
    }
    
    func didSelect(index: Int) {
        valueLabel.text = delegate?.CPDropDownList(self, titleFor: index)
        titleLabelTop?.constant = 8
        setSelectedStyles()
        
        UIView.animate(withDuration: animateDuration) { [weak self] in
            self?.headView.layoutIfNeeded()
        }
        
        delegate?.CPDropDownList(self, didSelect: index)
    }
    
    @objc func didTap() {
        if isOpen {
            dismiss()
            return
        }
        open()
    }
    
    func open() {
        isOpen = true
        delegate?.willOpen(self)
        setOpenedStyles()
        
        if let count = delegate?.numberOfItems(in: self) {
            var height = CGFloat(count) * itemHeight + 8
            if height > maxHeight {
                height = maxHeight
            }
            
            dropDownView.heightConstraint?.constant = height
            
            if tableView.numberOfRows(inSection: 0) == 0, count > 0 {
                tableView.reloadData()
            }
            
            if count == 0 {
                return
            }
        }
        
        UIView.animate(withDuration: animateDuration) { [weak self] in
            guard let self = self else { return }
            self.chevronImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
            //            self.superViewForDropDown?.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
        }
    }
    
    func dismiss(withDuration: CGFloat? = nil) {
        isOpen = false
        endEditing(true)
        delegate?.willDismiss(self)
        dropDownView.heightConstraint?.constant = 8
        headView.layer.borderColor = UIColor.borderColor.cgColor
        
        let duration = withDuration ?? animateDuration
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self = self else { return }
            self.chevronImageView.transform = CGAffineTransform(rotationAngle: 2 * .pi)
            self.superViewForDropDown?.layoutIfNeeded()
            //            self.superview?.layoutIfNeeded()
        }, completion: { [weak self] dismissed in
            
            guard let self = self else { return }
            if dismissed {
                self.delegate?.didDismiss(self)
            }
        })
    }
    
    func reload() {
        setDropDownView()
        tableView.reloadData()
    }
    
    func setSelectedItem() {
        guard let delegate = delegate else { return }
        
        let count = delegate.numberOfItems(in: self)
        
        guard count > 0 else { return }
        
        for item in 0...count - 1 where delegate.CPDropDownList(self, shouldSelect: item) {
            selectedIndex = item
            didSelect(index: item)
            return
        }
    }
    
    func clearSelection() {
        titleLabelTop?.constant = 16
        titleLabel.apply(TextStyle(fontStyle: .regular, size: 14), color: .black)
        
        selectedIndex = nil
        valueLabel.text = ""
        setDefaultStyles()
        reload()
    }
    
    func disable() {
        isUserInteractionEnabled = false
        
//        headView.backgroundColor = UIColor.grey500
//        titleLabel.textColor = .lightGrayText
//        valueLabel.textColor = .lightGrayText
//        chevronImageView.tintColor = .lightGrayText
        
    }
    
    func registerCell() {
        tableView.register(CPDropDownItemCell.self)
    }
}

// MARK: DropDown View
extension CPDropDownList: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        let backView = UIView()
        dropDownView.addSubview(backView)
        
        backView.align(top: 8, leading: 0, trailing: 0, bottom: 0)
        
        backView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.align(all: 0)
        tableView.separatorStyle = .none
        registerCell()
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true
        
        backView.backgroundColor = .white.withAlphaComponent(0.9)
        backView.layer.borderColor = UIColor.borderColor.cgColor
        
        backView.layer.cornerRadius = 8
        backView.layer.borderWidth = 1.5
        backView.clipsToBounds = false
        
        //        backView.boxShadow(x: 0, y: 0, radius: 2, color: .theme.withAlphaComponent(0.5), opacity: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfItems(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CPDropDownItemCell = tableView.dequeueCell(for: indexPath)
        
        if let title = delegate?.CPDropDownList(self, titleFor: indexPath.item) {
            cell.title = title
            cell.isSelected = selectedIndex == indexPath.item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let index = selectedIndex,
           let cell = tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? CPDropDownItemCell {
            cell.isSelected = false
        }
        
        selectedIndex = indexPath.item
        
        if let cell = tableView.cellForRow(at: indexPath) as? CPDropDownItemCell {
            cell.isSelected = true
        }
        didSelect(index: indexPath.item)
        dismiss()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
}

class CPDropDownItemCell: UITableViewCell {
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    override var isSelected: Bool {
        didSet {
            //            radionButton.isEnabled = isSelected
        }
    }
    
    let label = UILabel()
    let seperator = UIView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //        layer.borderWidth = 1
        selectionStyle = .none
        clipsToBounds = true
        addSubviews(views: label, seperator)
        
        label.align(leading: 16, trailing: 30, centerY: 0)
        label.apply(TextStyle(fontStyle: .regular, size: 13), color: .black)
        
        seperator.align(bottom: 0, height: 1, leadingAndTrailing: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
