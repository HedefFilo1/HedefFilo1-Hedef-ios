//
//  BrkdwnFlw1Stp2TowTruckViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation

protocol BrkdwnFlw1Stp2TowTruckVMCrdinatorDlgt: AnyObject {
    func getBack()
}

protocol BrkdwnFlw1Stp2TowTruckViewModelDelegate: BaseViewModelDelegate {
    
}

protocol BrkdwnFlw1Stp2TowTruckViewModelType: AnyObject {
    var coordinatorDelegate: BrkdwnFlw1Stp2TowTruckVMCrdinatorDlgt? { get set }
    var delegate: BrkdwnFlw1Stp2TowTruckViewModelDelegate? { get set }
    func getBack()
}

class BrkdwnFlw1Stp2TowTruckViewModel: BrkdwnFlw1Stp2TowTruckViewModelType {
    
    weak var coordinatorDelegate: BrkdwnFlw1Stp2TowTruckVMCrdinatorDlgt?
    weak var delegate: BrkdwnFlw1Stp2TowTruckViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}
