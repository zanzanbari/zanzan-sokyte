//
//  URLConstant.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/03.
//

import Foundation

struct URLConstant {
    
    // MARK: - base URL
    
    static let baseURL = "https://asia-northeast3-zanzan-18f89.cloudfunctions.net/api"
    
    // MARK: - Auth
    
    static let authLogin = "/auth/login"
    static let authReissueToken = "/auth/reissue/token"
    static let authSocialLogin = "/auth"
}
