//
//  NotificationViewController.swift
//  Copilot
//
//  Created by Jamal on 3/27/24.
//

import Foundation
import UIKit

class NotificationsViewController: UIViewController {
    
    var viewModel: NotificationsViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var selectAllContainer: UIView!
    @IBOutlet weak var selectAllView: UIView!
    @IBOutlet weak var selectAllLineView: UIView!
    @IBOutlet weak var selectAllLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: CPLightButton!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var deleteButton: CPButton!
    
    private var isSelectable = false {
        didSet {
            deleteIcon.tintColor = isSelectable ? .theme: .lightBlack
        }
    }
    
    private var selectAll = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        hideTabbarView()
        tableView.register(cellType: NotificationCell.self)
        tableView.register(cellType: SelectableNotificationCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        applyStyle()
        setTexts()
        cancelButton.isHidden = true
        deleteButton.isHidden = true
        deleteButton.isEnabled = true
        deleteIcon.image = deleteIcon.image?.withRenderingMode(.alwaysTemplate)
        deleteIcon.tintColor = .lightBlack
        selectAllContainer.clipsToBounds = true
        isSelectable = false
        selectAllContainer.heightConstraint?.constant = 0
        selectAllLineView.isHidden = true
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
        sortView.layer.cornerRadius = 10
        sortView.layer.borderWidth = 1
        sortView.layer.borderColor = UIColor.textGrey.cgColor
        sortLabel.apply(.greyS12B700)
        selectAllView.layer.borderColor = UIColor.borderColor.cgColor
        selectAllView.layer.borderWidth = 1
        selectAllView.layer.cornerRadius = 4
        selectAllLabel.apply(.blackS12R400)
    }
    
    func setTexts() {
        view.backgroundColor = .white
        titleLabel.text = Strings.notifications
        sortLabel.text = Strings.showAllOfThem
        cancelButton.setTitle(Strings.cancel, for: .normal)
        deleteButton.setTitle(Strings.deleteSelectedNotifications, for: .normal)
    }
    
    @IBAction func didTapBack() {
        showTabbarView()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapDeleteIcon() {
        isSelectable = true
        selectAllContainer.heightConstraint?.constant = 24
        tableView.reloadData()
    }
    
    @IBAction func didTapCancel() {
        isSelectable = false
        guard let items = viewModel.items else { return }
        for index in items.indices {
            viewModel.items?[index].selected = false
        }
        cancelButton.isHidden = true
        deleteButton.isHidden = true
        selectAllContainer.heightConstraint?.constant = 0
        selectAllView.layer.borderColor = UIColor.borderColor.cgColor
        selectAllLineView.isHidden = true
        
        tableView.reloadData()
    }
    
    @IBAction func didTapDelete() {
        isSelectable = true
        var ids: [Int] = []
        guard let items = viewModel.items else { return }
        for item in items {
            let selected = item.selected ?? false
            if selected {
                ids.append(item.id)
            }
        }
        viewModel.deleteNotifications(ids: ids)
    }
    
    @IBAction func didTapSelectAll() {
        selectAll = !selectAll
        
        let color: UIColor = selectAll ? .theme: .borderColor
        selectAllView.layer.borderColor = color.cgColor
        selectAllLineView.isHidden = !selectAll
        
        guard let items = viewModel.items else { return }
        for (index, item) in items.enumerated() {
            viewModel.items?[index].selected = selectAll
        }
        setSelectedItemsCount()
        tableView.reloadData()
    }
    
    @IBAction func didTapSort() {
        sortLabel.text = Strings.showUnread
        viewModel.showUnreads = !viewModel.showUnreads
        sortLabel.text = viewModel.showUnreads ? Strings.showUnread: Strings.showAllOfThem
        reloadData()
    }
    
    func setSelectedItemsCount() {
        let count = viewModel.visibleItems?.filter({$0.selected ?? false}).count ?? 0
        if count > 0 {
            cancelButton.isHidden = false
            deleteButton.isHidden = false
            let string = Strings.deleteSelectedNotifications.replacingOccurrences(of: "count", with: "\(count)")
            deleteButton.setTitle(string, for: .normal)
        } else {
            cancelButton.isHidden = true
            deleteButton.isHidden = true
        }
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.visibleItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSelectable {
            let cell: SelectableNotificationCell = tableView.dequeueReusableCell(for: indexPath)
            cell.selectionStyle = .none
            cell.item = viewModel.visibleItems?[indexPath.item]
            return cell
        }
        let cell: NotificationCell = tableView.dequeueReusableCell(for: indexPath)
        cell.item = viewModel.visibleItems?[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelectable {
            if let cell = tableView.cellForRow(at: indexPath) as? SelectableNotificationCell {
                
                if let item = viewModel.visibleItems?[indexPath.item] {
                    let selected = item.selected ?? false
                    if let index = viewModel.getItemIndex(id: item.id) {
                        viewModel.items?[index].selected = !selected
                        cell.checkBox.isSelected = !selected
                        setSelectedItemsCount()
                    }
                }
            }
        } else {
            if let id = viewModel.visibleItems?[indexPath.item].id {
                viewModel.readNotification(id: id)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func deleteRow(indexPath: IndexPath) {
        if let item = viewModel.visibleItems?[indexPath.item],
           let index = viewModel.getItemIndex(id: item.id) {
            viewModel.items?.remove(at: index)
            viewModel.deleteNotifications(ids: [item.id])
            //            reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: {[weak self]_, _, _ in
            // example of your delete function
            self?.deleteRow(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        let image = Images.whiteDeleteIcon
        deleteAction.image = image
        deleteAction.backgroundColor = .theme
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotificationsViewController: NotificationsViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
