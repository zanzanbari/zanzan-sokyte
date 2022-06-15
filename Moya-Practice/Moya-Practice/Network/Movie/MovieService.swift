//
//  MovieService.swift
//  Moya-Practice
//
//  Created by 소연 on 2022/06/15.
//

import Foundation

import Moya

enum MovieService {
    case popular(param: MovieRequest)
}

extension MovieService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popular:
            return .requestParameters(parameters: ["api_key": Const.apiKey,
                                                   "language" : "ko"],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .popular:
            return ["Content-Type": "application/json"]
        }
    }
}
