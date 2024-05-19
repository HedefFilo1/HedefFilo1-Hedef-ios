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
    func didSelect(_: CalendarViewController, date: Date)
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
    
    func setupUI() {
        applyStyle()
        setTexts()
        applyButton.isEnabled = true
        setupCalendar()
    }
    
    func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.firstWeekday = 2
        
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
        calendar.appearance.todayColor = .white
        calendar.appearance.titleTodayColor = .theme
        calendar.appearance.caseOptions = .weekdayUsesUpperCase
        calendar.calendarHeaderView.backgroundColor = .lightRed
        calendar.backgroundColor = .white
        calendar.boxShadow(xValue: 0, yValue: 20, radius: 4, color: .black, opacity: 0.08)
    }
    
    func applyStyle() {
        titleLabel.apply(.blackS18B700)
    }
    
    func setTexts() {
        titleLabel.text = App.getString(key: "copilotapp.servicemaintenance.service.detail.select.day")
        applyButton.setTitle(App.getString(key: "copilotapp.servicebreakdown.service.filter.apply.button"), for: .normal)
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapApply(_ sender: UIButton) {
        if let date = calendar.selectedDate {
            delegate?.didSelect(self, date: date)
        }
        dismiss(animated: true)
    }
}

extension CalendarViewController: FSCalendarDelegate,
                                  FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if !viewModel.shouldSelectSpecificDays {
            return true
        }
        
        let next15 = Calendar.current.date(byAdding: .day, value: 15, to: Date()) ?? Date()
        if isWeekend(date: date) || date < Date() || date > next15 {
            return false
        }
        return true
    }
    
    func isWeekend(date: Date) -> Bool {
        let components = date.get(.weekday)
        if components == 1 || components == 7 {
            return true
        }
        return false
    }
}

extension CalendarViewController: CalendarViewModelDelegate {
    
}
