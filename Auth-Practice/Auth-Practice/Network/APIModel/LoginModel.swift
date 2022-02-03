//
//  LoginModel.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/03.
//

import Foundation


// MARK: - Login Request 

struct LoginRequest: Codable {
    let email, password: String
}
