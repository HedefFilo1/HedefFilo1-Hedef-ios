//
//  ForgotPassword.swift
//  Copilot
//
//  Created by Jamal on 10/19/23.
//

import Foundation

struct ForgotPassword: Decodable {
    let result: ForgotPasswordResult
}

struct ForgotPasswordResult: Decodable {
    let isSuccess: Bool
    let responseMessage: String
    let timeLeftToResubmit: Int
}
