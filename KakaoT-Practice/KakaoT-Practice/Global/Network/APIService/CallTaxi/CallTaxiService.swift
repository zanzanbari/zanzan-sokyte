//
//  CallTaxiService.swift
//  KakaoT-Practice
//
//  Created by 소연 on 2022/03/08.
//

import Foundation

import Moya

enum CallTaxiService {
    case requestCallTaxi(parameter: CallTaxiRequest)
}

extension CallTaxiService: BaseTargetType {
    var path: String {
        switch self {
        case .requestCallTaxi: return URLConstant.callTaxi
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestCallTaxi: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .requestCallTaxi(let parameter):
            return .requestParameters(
                parameters:
                    ["origin": parameter.origin,
                     "carType": parameter.carType],
                encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .requestCallTaxi: return NetworkConstant.hasTokenHeader
        }
    }
}
