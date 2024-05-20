//
//  SearchViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/17/23.
//

import Foundation

struct SearchModel {
    let id: Int
    let title: String
}

protocol SearchViewModelCoordinatorDelegate: AnyObject {
    func getBack()
    func goToMenu()
    func goToSupport()
    func goToService()
    func goToAccident()
    func goToSettings()
    func goToGuides()
    func goToFeedback()
    func goToFAQ()
    func goToCallCenter()
}

protocol SearchViewModelDelegate: AnyObject {
    
}

protocol SearchViewModelType: AnyObject {
    
    var coordinatorDelegate: SearchViewModelCoordinatorDelegate? { get set }
    var delegate: SearchViewModelDelegate? { get set }
    var searchText: String { get set }
    var filteredItems: [SearchModel] { get }
    var searchItems: [SearchModel] { get set}
    func didSelect(item: SearchModel)
    func getBack()
}

class SearchViewModel: SearchViewModelType {
    
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    weak var delegate: SearchViewModelDelegate?
    
    var searchText: String = ""
    
    var filteredItems: [SearchModel] {
        print(searchText)
        if searchText == "" {
            return searchItems
        }
        return searchItems.filter({ $0.title.lowercased().contains(searchText.lowercased())})
    }
    
    var searchItems: [SearchModel] = [
        SearchModel(id: 0, title: "Daha Fazla"),
        SearchModel(id: 1, title: "Yardım"),
        SearchModel(id: 2, title: "Servis"),
        SearchModel(id: 3, title: "Kaza/Hasar"),
        SearchModel(id: 4, title: "Ayarlar"),
        SearchModel(id: 5, title: "Kılavuzlar"),
        SearchModel(id: 6, title: "Geri bildirim"),
        SearchModel(id: 7, title: "Sık Sorulan Sorular"),
        SearchModel(id: 8, title: "Çözüm Merkezi")
    ]
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func didSelect(item: SearchModel) {
        switch item.id {
        case 0:
            coordinatorDelegate?.goToMenu()
            getBack()
            
        case 1:
            coordinatorDelegate?.goToSupport()
            getBack()
            
        case 2:
            coordinatorDelegate?.goToService()
            getBack()
            
        case 3:
            coordinatorDelegate?.goToAccident()
            getBack()
            
        case 4:
            coordinatorDelegate?.goToSettings()
            return
            
        case 5:
            coordinatorDelegate?.goToGuides()
            
        case 6:
            coordinatorDelegate?.goToFeedback()
            
        case 7:
            coordinatorDelegate?.goToFAQ()
            
        case 8:
            coordinatorDelegate?.goToCallCenter()
            
        default:
            break
        }
    
    }
}
