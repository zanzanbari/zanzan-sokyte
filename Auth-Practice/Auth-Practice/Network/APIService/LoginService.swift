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
    case socialLogin(parameter: SocailLoginRequest)
}

extension LoginService: BaseTargetType {
    var path: String {
        switch self {
        case .postLogin: return URLConstant.authLogin
        case .authReissueToken: return URLConstant.authReissueToken
        case .socialLogin(let parameter): return URLConstant.authSocialLogin + "/\(parameter.social)/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin: return .post
        case .authReissueToken: return .get
        case .socialLogin: return .post
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
        case .socialLogin(let parameter):
            return .requestParameters(parameters: ["token": parameter.token], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postLogin, .socialLogin: return NetworkConstant.noTokenHeader
        case .authReissueToken: return NetworkConstant.hasRefreshTokenHedaer
        }
    }
}
