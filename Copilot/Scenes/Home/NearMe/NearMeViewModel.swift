//
//  NearMeViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/29/23.
//

import Foundation

protocol NearMeViewModelCoordinatorDelegate: AnyObject {
    func getBack()
    func presentFilters(delegate: FiltersViewControllerDelegate)
}

protocol NearMeViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
    func showSuppliersOnMap()
}

protocol NearMeViewModelType: AnyObject {
    var delegate: NearMeViewModelDelegate? { get set }
    var mark: String { get set }
    var suppliers: [Supplier]? { get set }
    func getSuppliers()
    func getBack()
    func presentFilters()
}

class NearMeViewModel: NearMeViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: NearMeViewModelCoordinatorDelegate?
    weak var delegate: NearMeViewModelDelegate?
    var mark: String = ""
    var suppliers: [Supplier]?
    
    func getSuppliers() {
        Loading.shared.show()
        APIService.getSupplier(mark: mark) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.suppliers = model.filter({
                    return $0.lon != nil && $0.lat != nil
                })
                self.delegate?.showSuppliersOnMap()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func presentFilters() {
        coordinatorDelegate?.presentFilters(delegate: self)
    }
}

extension NearMeViewModel: FiltersViewControllerDelegate {
    func didApply(filters: [Filter]) {
        guard filters.count > 0 else { return }
        if filters.filter({ $0.id == 111 }).count == 1 {
            getSuppliers()
        }
    }
}
