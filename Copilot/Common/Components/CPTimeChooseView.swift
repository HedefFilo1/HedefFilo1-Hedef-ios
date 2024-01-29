//
//  CPTimeChooseView.swift
//  Copilot
//
//  Created by Jamal on 1/2/24.
//

import Foundation
import UIKit

protocol CPTimeNumberChooseViewDelegate: AnyObject {
    func didTap(_: CPTimeChooseView)
    func didSelect(_: CPTimeNumberChooseView, number: String)
    func superViewForDropDown(in cpTimeChooseView: CPTimeNumberChooseView) -> UIView?
}

class CPTimeNumberChooseView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    weak var delegate: CPTimeNumberChooseViewDelegate? {
        didSet {
            setDropDownView()
        }
    }
    
    private var hasDropDownAdded = false
    
    var parentView: UIView?
    
    var selectedNumber: String? {
        didSet {
            textField.text = selectedNumber
        }
    }
    var numbers = ["01", "01", "1", "1"]
    let textField = UITextField()
    let icon = UIImageView()
    let dropDownView = UIView()
    let tableView = UITableView()
    
    var isOpen = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //        setDropDownView()
    }
    
    func setup() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        clipsToBounds = true
        
        addSubview(textField)
        textField.align(leading: 0, trailing: 48, topAndBottom: 0)
        textField.apply(.custom(.fieldsText, .regular, 16))
        textField.setLeftPadding(20)
        textField.apply(.blackS16R400)
        textField.delegate = self
        textField.keyboardType = .numberPad
        
        addSubview(icon)
        icon.align(trailing: 20, widthAndHeight: 24, centerY: 0)
        icon.image = Images.chevronBlackDown
        
        let button = UIButton()
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        addSubview(button)
        button.align(leading: 0, trailing: 0, topAndBottom: 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        return range.location < 2
    }
    
    @objc func didTap() {
        if isOpen {
            closeList()
        } else {
            showList()
        }
    }
    
    func showList() {
        isOpen = true
        var height =  CGFloat(numbers.count * 26)
        if height > 104 {
            height = 104
        }
        dropDownView.heightConstraint?.constant = height
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.parentView?.layoutIfNeeded()
        }
    }
    
    func closeList() {
        isOpen = false
        dropDownView.heightConstraint?.constant = 0
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func setDropDownView() {
        if hasDropDownAdded { return }
        
        if let view = delegate?.superViewForDropDown(in: self) {
            view.addSubview(dropDownView)
            parentView = view
        } else {
            superview?.superview?.addSubview(dropDownView)
            parentView = superview?.superview
        }
        dropDownView.clipsToBounds = false
        dropDownView.align(toView: self, trailing: 0, width: 68, height: 0.1, topToBottom: 4)
        hasDropDownAdded = true
        dropDownView.backgroundColor = .white
        dropDownView.layer.cornerRadius = 4
        dropDownView.boxShadow(xValue: 0, yValue: 4, radius: 8, color: .black, opacity: 0.16)
        setTableView()
    }
    
    func setTableView() {
        
        dropDownView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.align(all: 0)
        tableView.separatorStyle = .none
        tableView.register(CPTimeCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CPTimeCell = tableView.dequeueCell(for: indexPath)
        cell.label.text = numbers[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNumber = numbers[indexPath.item]
        delegate?.didSelect(self, number: numbers[indexPath.item])
        closeList()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 26
    }
    
}

class CPTimeCell: UITableViewCell, Reusable {
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //        layer.borderWidth = 1
        selectionStyle = .none
        clipsToBounds = true
        addSubviews(views: label)
        
        label.align(leading: 0, trailing: 0, centerY: 0)
        label.apply(.blackS14R400)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol CPTimeChooseViewDelegate: CPTimeNumberChooseViewDelegate {
    
}

class CPTimeChooseView: UIView {
    
    weak var delegate: CPTimeChooseViewDelegate? {
        didSet {
            hourView.delegate = self
            minuteView.delegate = self
        }
    }
    
    var timeSelected: Bool {
        return hourView.selectedNumber != nil && minuteView.selectedNumber != nil
    }
    
    var selecteTimeString: String? {
        if let hour = hourView.selectedNumber, let minute = minuteView.selectedNumber {
            return "\(hour):\(minute)"
        }
        return nil
    }
    
    var seletedHour: String? {
        return hourView.selectedNumber
    }
    
    var seletedMinute: String? {
        return minuteView.selectedNumber
    }
    
    let dotslabel = UILabel()
    let hourView = CPTimeNumberChooseView()
    let minuteView = CPTimeNumberChooseView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
        addSubview(dotslabel)
        dotslabel.align(centerX: 0, centerY: 0)
        dotslabel.apply(.custom(.black, .bold, 20))
        dotslabel.text = ":"
        
        addSubview(hourView)
        hourView.align(leading: 0, topAndBottom: 0)
        hourView.align(toView: dotslabel, trailingToLeading: -12)
        hourView.numbers = []
        for num in 0...17 {
            var item = "\(num)"
            if num < 10 {
                item = "0\(num)"
            }
            hourView.numbers.append(item)
        }
        
        addSubview(minuteView)
        minuteView.align(trailing: 0, topAndBottom: 0)
        minuteView.align(toView: dotslabel, leadingToTrailing: 12)
        minuteView.numbers = ["00", "15", "30", "45"]
    }
    
    func set(hourNumber: String, minuteNumber: String) {
        hourView.selectedNumber = hourNumber
        minuteView.selectedNumber = minuteNumber
    }
}

extension CPTimeChooseView: CPTimeNumberChooseViewDelegate {
    
    func didTap(_ view: CPTimeChooseView) {
        delegate?.didTap(view)
    }
    
    func didSelect(_ view: CPTimeNumberChooseView, number: String) {
        if view == hourView, number == "17" {
            minuteView.selectedNumber = "00"
            minuteView.numbers = ["00"]
            minuteView.tableView.reloadData()
        } else {
            minuteView.numbers = ["00", "15", "30", "45"]
            minuteView.tableView.reloadData()
        }
        delegate?.didSelect(view, number: number)
    }
    
    func superViewForDropDown(in cpTimeChooseView: CPTimeNumberChooseView) -> UIView? {
        return delegate?.superViewForDropDown(in: cpTimeChooseView)
    }
    
}
