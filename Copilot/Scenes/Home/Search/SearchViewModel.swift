//
//  SearchViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/17/23.
//

import Foundation

protocol SearchViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol SearchViewModelDelegate: AnyObject {
    
}

protocol SearchViewModelType: AnyObject {
    
    var coordinatorDelegate: SearchViewModelCoordinatorDelegate? { get set }
    var delegate: SearchViewModelDelegate? { get set }
    var pastSeraches: [String] { get set}
    func getBack()
}

class SearchViewModel: SearchViewModelType {
    
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    weak var delegate: SearchViewModelDelegate?
    
    var pastSeraches: [String] = [
        "Kış Lastiği Kılavuzu",
        "Kış Lastiği Talebi",
        "Benzin İstasyonu",
        "Starbucs"
    ]
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
