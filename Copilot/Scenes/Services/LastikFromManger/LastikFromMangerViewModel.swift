//
//  LastikFromMangerViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol LastikFromMangerVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToRequestLastikResult()
}

protocol LastikFromMangerViewModelDelegate: BaseViewModelDelegate {
    
}

protocol LastikFromMangerViewModelType: AnyObject {
    var coordinatorDelegate: LastikFromMangerVMCoordinatorDelegate? { get set }
    var delegate: LastikFromMangerViewModelDelegate? { get set }
    
    func getBack()
    func goToRequestLastikResult()
    func goToRequestNewLastik(tireType: TireSupportType)
}

class LastikFromMangerViewModel: LastikFromMangerViewModelType {
    
    weak var coordinatorDelegate: LastikFromMangerVMCoordinatorDelegate?
    weak var delegate: LastikFromMangerViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestLastikResult() {
        coordinatorDelegate?.goToRequestLastikResult()
    }
    
    func goToRequestNewLastik(tireType: TireSupportType) {
        Loading.shared.show()
        APIService.createTireCase(tireType: tireType,
                                  towTruck: false,
                                  supplierName: "",
                                  supplierPhone: "",
                                  city: "",
                                  district: "",
                                  appointmentDate: Date()) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }

            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                self.goToRequestLastikResult()
            }
        }
    }
}
