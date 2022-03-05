//
//  Temp.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/02/24.
//

import Foundation

import Moya

enum DirectionsService {
    case getDirections(parameter: DirectionsRequest)
}

extension DirectionsService: BaseTargetType {
    var path: String {
        switch self {
        case .getDirections: return URLConstant.direction
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDirections: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDirections(let parameter):
            return .requestParameters(parameters: ["origin": parameter.origin,
                                                   "destination": parameter.destination], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getDirections: return NetworkConstant.hasTokenHeader
        }
    }
}
