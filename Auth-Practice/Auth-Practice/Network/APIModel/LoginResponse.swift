//
//  LoginResponse.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/03.
//

import Foundation

// MARK: - Login Response

struct LoginResponse: Codable {
    let id: Int
    let email, nick, idFirebase, token: String
    let createdAt: String
    let isDeleted: Bool
    let jwtToken: JwtToken
}

// MARK: - JwtToken

struct JwtToken: Codable {
    let accesstoken, refreshtoken: String
}
