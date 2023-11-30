//
//  Case.swift
//  Copilot
//
//  Created by Jamal on 11/29/23.
//

import Foundation
struct Case: Decodable {
    let caseNumber: String
    let supplierName: String
    let appointmentDate: String
    let recordType: String
    let status: String
}
