//
//  LoginResponse.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/03.
//

import Foundation

// MARK: - Login Response

struct LoginResponse: Codable {
    let nickname, accesstoken, refreshtoken: String
}
