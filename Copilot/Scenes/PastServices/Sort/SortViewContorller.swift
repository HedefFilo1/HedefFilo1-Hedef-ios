//
//  PastServicesSortViewContorller.swift
//  Copilot
//
//  Created by Jamal on 4/1/24.
//

import Foundation
import UIKit

protocol SortViewControllerDelegate: AnyObject {
    func didTapApply(ascending: Bool)
}

class SortViewController: SheetViewController {
    
    var viewModel: SortViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 222
    }
    weak var delegate: SortViewControllerDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ascendingRadio: CPRadioBox!
    @IBOutlet weak var ascendingLabel: UILabel!
    @IBOutlet weak var descendingRadio: CPRadioBox!
    @IBOutlet weak var descendingLabel: UILabel!
    @IBOutlet weak var applyButton: CPButton!
    
    var openedList: CPDropDownList?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        applyStyle()
        setTexts()
        applyButton.isEnabled = true
        ascendingRadio.isSelected = true
    }
    
    func applyStyle() {
        view.backgroundColor = .white
        titleLabel.apply(.blackS24B700)
        ascendingRadio.layer.cornerRadius = 12
        descendingRadio.layer.cornerRadius = 12
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.sort.button")
        ascendingLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.sort.new.old")
        descendingLabel.text = App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.sort.old.new")
        applyButton.setTitle(App.getString(key: "copilotapp.pastservicemaintenance.past.maintenance.operation.filter.apply.button"), for: .normal)
        
        if let text = viewModel.newToOldText {
            ascendingLabel.text = text
        }
        
        if let text = viewModel.oldToNewText {
            descendingLabel.text = text
        }
        
        if let text = viewModel.applyText {
            applyButton.setTitle(text, for: .normal)

        }
    }

    @IBAction func didTapClose() {
        dismiss(animated: true)
    }
    
    @IBAction func didTapAscending() {
        ascendingRadio.isSelected = true
        descendingRadio.isSelected = false
    }
    
    @IBAction func didTapDescending() {
        ascendingRadio.isSelected = false
        descendingRadio.isSelected = true
    }
   
    @IBAction func didTapApply() {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            let ascending = !ascendingRadio.isSelected
            self.delegate?.didTapApply(ascending: ascending)
        }
    }
}

extension SortViewController: SortViewModelDelegate {
    
}
