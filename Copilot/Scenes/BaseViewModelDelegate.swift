//
//  BaseViewModelDelegate.swift
//  Copilot
//
//  Created by Jamal on 12/13/23.
//

import Foundation

protocol BaseViewModelDelegate: AnyObject {
    func showSuccess(title: String, message: String)
    func showError(title: String, message: String)
}
