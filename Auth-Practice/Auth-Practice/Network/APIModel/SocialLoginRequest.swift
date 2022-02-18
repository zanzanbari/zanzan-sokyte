//
//  SocialLoginRequest.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/18.
//

import Foundation

// MARK: - Login Request

struct SocailLoginRequest: Codable {
    let social, token: String
}

