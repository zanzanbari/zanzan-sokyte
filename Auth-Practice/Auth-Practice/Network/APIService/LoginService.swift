//
//  LoginAPPI.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/03.
//

import Foundation

import Moya

enum LoginService {
    case postLogin(parameter: LoginRequest)
}

extension LoginService: BaseTargetType {
    var path: String {
        switch self {
        case .postLogin: return URLConstant.authLogin
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postLogin(let parameter):
            let parameter: [String: Any] = ["email": parameter.email,
                                            "password": parameter.password]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postLogin: return NetworkConstant.noTokenHeader
        }
    }
}
