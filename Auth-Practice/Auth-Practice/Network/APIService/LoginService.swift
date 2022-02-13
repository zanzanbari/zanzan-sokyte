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
    case authReissueToken
}

extension LoginService: BaseTargetType {
    var path: String {
        switch self {
        case .postLogin: return URLConstant.authLogin
        case .authReissueToken: return URLConstant.authReissueToken
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin: return .post
        case .authReissueToken: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .postLogin(let parameter):
            let parameter: [String: Any] = ["email": parameter.email,
                                            "password": parameter.password]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        case .authReissueToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postLogin: return NetworkConstant.noTokenHeader
        case .authReissueToken: return NetworkConstant.hasRefreshTokenHedaer
        }
    }
}
