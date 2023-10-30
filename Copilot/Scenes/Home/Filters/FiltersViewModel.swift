//
//  FiltersViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/30/23.
//

import Foundation

class Filter {
    let tilte: String
    let subFilters: [Filter]?
    var selected = false
    var showSubFilters = false
    
    init(tilte: String, subFilters: [Filter]?) {
        self.tilte = tilte
        self.subFilters = subFilters
    }
}

protocol FiltersViewModelCoordinatorDelegate: AnyObject {
    func dismiss()
}

protocol FiltersViewModelDelegate: AnyObject {
    
}

protocol FiltersViewModelType: AnyObject {
    var delegate: FiltersViewModelDelegate? { get set }
    var filters: [Filter] { get set }
    func dismiss()
}

class FiltersViewModel: FiltersViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: FiltersViewModelCoordinatorDelegate?
    weak var delegate: FiltersViewModelDelegate?
    
    var filters: [Filter] = [
        Filter(tilte: "İspark", subFilters: nil),
        Filter(tilte: "Özel Otoparklar", subFilters: nil),
        Filter(tilte: "Benzin İstasyonu", subFilters: [
            Filter(tilte: "Yemek Kartı Geçenler", subFilters: nil),
            Filter(tilte: "Starbucks Bulunanlar", subFilters: nil),
            Filter(tilte: "Kahve Dünyası Bulunanlar", subFilters: nil),
        ]),
        Filter(tilte: "Karakol", subFilters: nil),
        Filter(tilte: "Hastane", subFilters: nil),
        Filter(tilte: "İtfaiye", subFilters: nil),
        Filter(tilte: "Trafik Bilgisi", subFilters: nil),
        Filter(tilte: "Bankalar", subFilters: nil),
        Filter(tilte: "Gişeler", subFilters: nil)
    ]
    
    func dismiss() {
        coordinatorDelegate?.dismiss()
    }
    
}
