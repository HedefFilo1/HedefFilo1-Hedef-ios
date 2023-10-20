//
//  Signup.swift
//  Copilot
//
//  Created by Jamal on 10/19/23.
//

import Foundation

struct Signup: Decodable {
    let result: SignupResult
}

struct SignupResult: Decodable {
    
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    let expiresIn: Int
    let identityToken: String?
    let isSuccess: Bool
    let responseMessage: String
}
