//
//  CalendarViewController.swift
//  Copilot
//
//  Created by Jamal on 1/2/24.
//

import Foundation
import UIKit
import FSCalendar

protocol CalendarViewControllerDelegate: AnyObject {
    func didSelect(date: Date)
}

class CalendarViewController: SheetViewController {
    
    var viewModel: CalendarViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override var presentationHeight: CGFloat {
        return 445
    }
    
    var delegate: CalendarViewControllerDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var applyButton: CPButton!
    
    private var selectedDate: Date?
    
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
        setupCalendar()
    }
    
    func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.scrollDirection = .horizontal
        calendar.placeholderType = .none
        calendar.locale = Locale(identifier: "tr")
        
        calendar.appearance.headerTitleFont = FontStyle.bold.asUIFont(size: 16)
        calendar.appearance.headerTitleColor = .theme
        
        calendar.appearance.titleFont = FontStyle.regular.asUIFont(size: 14)
        calendar.appearance.titleDefaultColor = .black
        
        calendar.appearance.weekdayFont = FontStyle.regular.asUIFont(size: 12)
        calendar.appearance.weekdayTextColor = .textLightGrey
        
        calendar.appearance.titleWeekendColor = .black
        calendar.appearance.borderRadius = 0.3
        calendar.appearance.selectionColor = .theme
        calendar.appearance.todayColor = .theme
        calendar.appearance.caseOptions = .weekdayUsesUpperCase
        calendar.calendarHeaderView.backgroundColor = .lightRed
        calendar.backgroundColor = .white
        calendar.boxShadow(xValue: 0, yValue: 20, radius: 4, color: .black, opacity: 0.08)
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = Strings.selectDay
        applyButton.setTitle(Strings.apply, for: .normal)
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapApply(_ sender: UIButton) {
        if let date = calendar.selectedDate {
            delegate?.didSelect(date: date)
        }
        dismiss(animated: true)
    }
}

extension CalendarViewController: FSCalendarDelegate,
                                  FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
    }
}

extension CalendarViewController: CalendarViewModelDelegate {
    
}